
CREATE TABLE dbo.FactRestaurantInspection
(
  inspection_key INT IDENTITY NOT NULL,
  inspection_date_key INT NOT NULL,
  restaurant_key INT NOT NULL,
  address_key INT NOT NULL,
  cuisine_description_key INT NOT NULL
)
GO


CREATE TABLE dbo.FactRestaurantInspectionViolation
(
  inspection_violation_key INT IDENTITY NOT NULL,
  inspection_key INT NOT NULL,
  violation_key INT NOT NULL,
  inspection_action_key INT NOT NULL,
  inspection_type_key INT NOT NULL,
  inspection_grade_key INT NOT NULL,
  critical_flag_key INT NOT NULL,
  score SMALLINT
)
GO
