import pandas as pd
from azure.identity import DefaultAzureCredential
from azure.storage.filedatalake import DataLakeServiceClient
from dotenv import load_dotenv
load_dotenv(".env")

# Read data from website and write to a parquet file in local
df = pd.read_csv("https://data.cityofnewyork.us/api/views/43nn-pn8j/rows.csv")

# transform data
df.columns = map(str.lower, df.columns)
df.columns = df.columns.str.replace(' ', '_')
df.inspection_date = pd.to_datetime(df.inspection_date).dt.date
df.grade_date = pd.to_datetime(df.grade_date).dt.date
df.record_date = pd.to_datetime(df.record_date).dt.date

# write data to local
unique_file_path = 'restaurant_inspection_results.parquet'
df.to_parquet(unique_file_path, engine = 'pyarrow', compression = 'snappy')

# Upload a file to adls gen 2
storage_account_name = 'restaurantinspectionraw'
file_system_name = 'data'
credential = DefaultAzureCredential()

try:
    service_client = DataLakeServiceClient(account_url="{}://{}.dfs.core.windows.net".format("https", storage_account_name), credential=credential)

    file_system_client = service_client.get_file_system_client(file_system="data")

    directory_client = file_system_client.get_directory_client("full")
    
    file_client = directory_client.get_file_client(unique_file_path)

    local_file = open(unique_file_path,'rb')

    file_contents = local_file.read()


    file_client.upload_data(file_contents, overwrite=True)

except Exception as e:
    print(e)


print(len(df))
print("Parquet file uploaded successfully.")