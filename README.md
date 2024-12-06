## Project Summary: Vehicle Theft Analysis

This project is a comprehensive data analysis of vehicle theft patterns, utilizing advanced SQL techniques to explore when, which, and where vehicles are most likely to be stolen. The analysis provides deep insights into vehicle theft characteristics through systematic, multi-dimensional exploration.

### Project Strengths
- Detailed temporal analysis
- Vehicle type and characteristic investigation
- Geospatial theft pattern exploration
- Advanced SQL querying techniques
- Comprehensive data exploration

### File-by-File Analysis

#### 1. `obj1_period_wise_analysis.sql`
Focuses on temporal patterns of vehicle theft:

Key Analytical Approaches:
- Year-wise vehicle theft count
- Monthly theft distribution
- Day of the week theft analysis
- Uses date and time functions:
  - `year()`
  - `month()`
  - `dayofweek()`
- Includes case statements for day name conversion

Insights Generated:
- Temporal trends in vehicle theft
- Most vulnerable periods for vehicle theft

#### 2. `obj2_type_wise_analysis.sql`
Explores vehicle characteristics and theft vulnerabilities:

Key Analytical Techniques:
- Vehicle type frequency analysis
- Average vehicle age at theft
- Luxury vs. standard vehicle theft percentages
- Advanced JOIN and aggregation techniques
- Pivot table creation for color and vehicle type analysis

Complex Query Highlights:
- Subqueries for percentage calculations
- Case statement transformations
- Detailed color and vehicle type mapping

Insights Generated:
- Most stolen vehicle types
- Luxury vehicle theft propensity
- Color-based theft patterns

#### 3. `obj3_region_wise_analysis.sql`
Investigates geographical aspects of vehicle theft:

Key Analysis:
- Regional vehicle theft counts
- Population and density correlation with theft
- Location-based JOIN techniques
