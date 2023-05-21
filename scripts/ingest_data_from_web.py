import pandas as pd

def read_csv(path: str):
    
    dtypes = {
        'CAMIS': 'Int64',
        'DBA': 'object',
        'BORO': 'object',
        'BUILDING': 'object',
        'STREET': 'object',
        'ZIPCODE': 'object',
        'PHONE': 'object',
        'CUISINE DESCRIPTION': 'object',
        'INSPECTION DATE': 'object',
        'ACTION': 'object',
        'VIOLATION CODE': 'object',
        'VIOLATION DESCRIPTION': 'object',
        'CRITICAL FLAG': 'object',
        'SCORE': 'Int64',
        'GRADE': 'object',
        'GRADE DATE': 'object',
        'RECORD DATE': 'object',
        'INSPECTION TYPE': 'object',
        'Latitude': 'float64',
        'Longitude': 'float64',
        'Community Board': 'Int64',
        'Council District': 'Int64',
        'Census Tract': 'Int64',
        'BIN': 'Int64',
        'BBL': 'Int64',
        'NTA': 'object'
    }

    df = pd.read_csv(path, dtype=dtypes)

    df.columns = map(str.lower, df.columns)
    df.columns = df.columns.str.replace(' ', '_')

    df.inspection_date = pd.to_datetime(df.inspection_date).dt.date
    df.grade_date = pd.to_datetime(df.grade_date).dt.date

    print(df.record_date)

if __name__ == "__main__":
    
    path = "../data/DOHMH_New_York_City_Restaurant_Inspection_Results.csv"

    read_csv(path)