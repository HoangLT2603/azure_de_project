CREATE TABLE [dim_restaurant_places] (
  [restaurant_key] integer PRIMARY KEY,
  [restaurant_id] integer,
  [restaurant_name] nvarchar(255),
  [phone] integer
)
GO

CREATE TABLE [dim_cuisine] (
  [cuisine_description_key] integer PRIMARY KEY,
  [cuisine_description] nvarchar(255)
)
GO

CREATE TABLE [dim_date] (
  [date_key] integer PRIMARY KEY,
  [date] timestamp,
  [day] integer,
  [month] integer,
  [quarter] integer,
  [year] integer
)
GO

CREATE TABLE [dim_addresses] (
  [address_key] integer PRIMARY KEY,
  [buiding] nvarchar(255),
  [street] nvarchar(255),
  [zipcode] nvarchar(255),
  [boro_name] nvarchar(255),
  [latitude] integer,
  [longitude] integer,
  [community_board] integer,
  [council_district] integer
)
GO

CREATE TABLE [fact_restaurant_inspections] (
  [inspection_key] integer PRIMARY KEY,
  [inspection_date_key] integer,
  [restaurant_key] integer,
  [address_key] integer,
  [cuisine_description_key] integer
)
GO

CREATE TABLE [dim_violations] (
  [violation_key] integer PRIMARY KEY,
  [violation_id] integer,
  [violation_description] nvarchar(255)
)
GO

CREATE TABLE [dim_inspection_actions] (
  [inspection_action_key] integer PRIMARY KEY,
  [inspection_action] nvarchar(255)
)
GO

CREATE TABLE [dim_inspection_types] (
  [inspection_type_key] integer PRIMARY KEY,
  [inspection_type] nvarchar(255)
)
GO

CREATE TABLE [dim_inspection_grades] (
  [inspection_grade_key] integer PRIMARY KEY,
  [inspection_grade] nvarchar(255)
)
GO

CREATE TABLE [dim_critical_flags] (
  [critical_flag_key] integer PRIMARY KEY,
  [critical_flag] nvarchar(255)
)
GO

CREATE TABLE [fact_restaurant_inspection_violations] (
  [inspection_violation_key] integer PRIMARY KEY,
  [inspection_key] integer,
  [violation_key] integer,
  [inspection_action_key] integer,
  [inspection_type_key] integer,
  [inspection_grade_key] integer,
  [critical_flag_key] integer,
  [score] integer
)
GO

ALTER TABLE [fact_restaurant_inspections] ADD FOREIGN KEY ([inspection_date_key]) REFERENCES [dim_date] ([date_key])
GO

ALTER TABLE [fact_restaurant_inspections] ADD FOREIGN KEY ([address_key]) REFERENCES [dim_addresses] ([address_key])
GO

ALTER TABLE [fact_restaurant_inspections] ADD FOREIGN KEY ([cuisine_description_key]) REFERENCES [dim_cuisine] ([cuisine_description_key])
GO

ALTER TABLE [fact_restaurant_inspections] ADD FOREIGN KEY ([restaurant_key]) REFERENCES [dim_restaurant_places] ([restaurant_key])
GO

ALTER TABLE [fact_restaurant_inspection_violations] ADD FOREIGN KEY ([inspection_key]) REFERENCES [fact_restaurant_inspections] ([inspection_key])
GO

ALTER TABLE [fact_restaurant_inspection_violations] ADD FOREIGN KEY ([violation_key]) REFERENCES [dim_violations] ([violation_key])
GO

ALTER TABLE [fact_restaurant_inspection_violations] ADD FOREIGN KEY ([inspection_action_key]) REFERENCES [dim_inspection_actions] ([inspection_action_key])
GO

ALTER TABLE [fact_restaurant_inspection_violations] ADD FOREIGN KEY ([inspection_type_key]) REFERENCES [dim_inspection_types] ([inspection_type_key])
GO

ALTER TABLE [fact_restaurant_inspection_violations] ADD FOREIGN KEY ([inspection_grade_key]) REFERENCES [dim_inspection_grades] ([inspection_grade_key])
GO

ALTER TABLE [fact_restaurant_inspection_violations] ADD FOREIGN KEY ([critical_flag_key]) REFERENCES [dim_critical_flags] ([critical_flag_key])
GO
