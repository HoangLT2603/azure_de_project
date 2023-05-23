

CREATE TABLE dbo.DimRestaurantPlaces
(
  restaurant_key INT IDENTITY NOT NULL,
  restaurant_id INT,
  restaurant_name NVARCHAR(200),
  phone NVARCHAR(15),
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  is_current BIT NOT NULL
)
WITH
(
  DISTRIBUTION = REPLICATE,
  CLUSTERED COLUMNSTORE INDEX
);
GO

CREATE TABLE dbo.DimCuisine (
  cuisine_description_key INT IDENTITY NOT NULL,
  cuisine_description NVARCHAR(255),
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  is_current BIT NOT NULL
)
WITH
(
  DISTRIBUTION = REPLICATE,
  CLUSTERED COLUMNSTORE INDEX
);
GO

CREATE TABLE dbo.DimDate
( 
  date_key INT NOT NULL,
  date_id DATETIME NOT NULL,
  day_of_month INT NOT NULL,
  day_of_week INT NOT NULL,
  day_name NVARCHAR(15) NOT NULL,
  month_of_year INT NOT NULL,
  month_name NVARCHAR(15) NOT NULL,
  quarter INT NOT NULL,
  year INT NOT NULL
)
WITH
(
  DISTRIBUTION = REPLICATE,
  CLUSTERED COLUMNSTORE INDEX
);

CREATE TABLE dbo.DimAddress (
  address_key INT IDENTITY NOT NULL,
  boro NVARCHAR(20) NULL,
  buiding NVARCHAR(10) NULL,
  street NVARCHAR(255) NULL,
  zipcode NVARCHAR(10) NULL,
  latitude INT,
  longitude INT,
  community_board INT,
  council_district INT,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  is_current BIT NOT NULL
)
WITH
(
  DISTRIBUTION = REPLICATE,
  CLUSTERED COLUMNSTORE INDEX
);
GO


CREATE TABLE dbo.DimViolation (
  violation_key INT IDENTITY NOT NULL,
  violation_id NVARCHAR(10),
  violation_description NVARCHAR(500),
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  is_current BIT NOT NULL
)
WITH
(
  DISTRIBUTION = REPLICATE,
  CLUSTERED COLUMNSTORE INDEX
);
GO

CREATE TABLE dbo.DimInspectionAction (
  inspection_action_key INT IDENTITY NOT NULL,
  inspection_action NVARCHAR(255),
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  is_current BIT NOT NULL
)
WITH
(
  DISTRIBUTION = REPLICATE,
  CLUSTERED COLUMNSTORE INDEX
);
GO

CREATE TABLE dbo.DimInspectionType (
  inspection_type_key INT IDENTITY NOT NULL,
  inspection_type NVARCHAR(100),
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  is_current BIT NOT NULL
)
WITH
(
  DISTRIBUTION = REPLICATE,
  CLUSTERED COLUMNSTORE INDEX
);
GO

CREATE TABLE dbo.DimInspectionGrade (
  inspection_grade_key INT IDENTITY NOT NULL,
  inspection_grade NVARCHAR(255),
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  is_current BIT NOT NULL
)
WITH
(
  DISTRIBUTION = REPLICATE,
  CLUSTERED COLUMNSTORE INDEX
);
GO

CREATE TABLE dbo.DimCriticalFlag (
  critical_flag_key INT IDENTITY NOT NULL,
  critical_flag NVARCHAR(30),
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  is_current BIT NOT NULL
)
WITH
(
  DISTRIBUTION = REPLICATE,
  CLUSTERED COLUMNSTORE INDEX
);
GO

