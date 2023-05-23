

CREATE TABLE dbo.StageInspection 
(
    camis INT IDENTITY NOT NULL,
    dba NVARCHAR(200) NULL,
    boro NVARCHAR(20) NULL,
    buiding NVARCHAR(10) NULL,
    street NVARCHAR(255) NULL,
    zipcode NVARCHAR(10) NULL,
    phone NVARCHAR(15) NULL ,
    cuisine_description NVARCHAR(255) NULL,
    inspection_date DATE NOT NULL,
    action NVARCHAR(255) NULL,
    violation_code NVARCHAR(10),
    violation_description NVARCHAR(500) NULL,
    critical_flag NVARCHAR(30) NULL,
    score SMALLINT,
    grade NVARCHAR(1) NULL,
    grade_date DATE,
    record_date DATE,
    inspection_type NVARCHAR(100) NULL,
    latitude INT,
    longitude INT,
    community_board INT,
    council_district INT
)
WITH
(
    DISTRIBUTION = ROUND_ROBIN,
    CLUSTERED COLUMNSTORE INDEX
);
GO

CREATE TABLE dbo.StageDate
(
    [date] DATE NOT NULL
)
WITH
(
    DISTRIBUTION = ROUND_ROBIN,
    CLUSTERED COLUMNSTORE INDEX
);
GO
