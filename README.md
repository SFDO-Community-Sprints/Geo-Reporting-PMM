# Geographic Reporting enhancements for PMM and NPSP

# Project Overview
## Vision & Goals
Our goal is to create a reference architecture for users to be able to map addresses to geographic regions based on a given shapefile. For example, a frequent use-case for non-profits is reporting county-level data, but the standard functionality of the Data.com geocoder does not return data at that level -- only the latitude and longitude coordinates.  

* Provide a framework for someone lightly-familar with GIS to create reference records in Salesforce to map to non-standard geographies. 
* Create a solution that allows us to match a single latitude-longitude pair to one of the reference records.
* Connect this geodata to program services and other objects leveraged in the PMM Module.
* Create some basic reporting that would allow and end-user to analyze data based off the linkage to a region. 

## Project Vertical
Non-profit, Education, other use-cases as well. 

## Hub Group Link

# Project Team

## Sprint (10-20-2021):

### Project Team Accomplishments
- Created Demo video. 
- Cleaned up github!

Full Name            | Team Role     | Github Username                                         | 
------------         | ------------- | -------------                                           |
Justin Gilmore       | Group Leader  | [justinsgilmore](https://github.com/justinsgilmore)     | 
Jon	Sayer            | Contributor   | [jonsayer](https://github.com/jonsayer)                 | 
Meg Gray             | Contributor   | [meggraySFDO](https://github.com/meggraySFDO)           | 

## Sprint (06-09-2021):

### Project Team Accomplishments
- Created Geographic Definition object
- Wrote Apex for consuming a latitude and longitude and returning the Geographic Definition that point is within
- Wrote Apex for processing Geographic Definition records for use. 

Full Name            | Team Role     | Github Username                                         | 
------------         | ------------- | -------------                                           |
Justin Gilmore       | Group Leader  | [justinsgilmore](https://github.com/justinsgilmore)     | 
Mike Kikta           | Contributor   | [mkikta-traction](https:/github.com/mkikta-traction)    |
Tina Brint           | Contributor   | [jade888](https:/github.com/jade888)                    | 
Claudio	Moraes       | Contributor   | [crmoraes](https://github.com/crmoraes)                 |
Meera	Nilekani       | Contributor   | [radmeera](https://github.com/radmeera)                 |
Jessie	Rymph        | Contributor   | [forthesales](https://github.com/forthesales)           |
Jon	Sayer            | Contributor   | [jonsayer](https://github.com/jonsayer)                 | 
Peter	White          | Contributor   | [pawhite-gh](https://github.com/pawhite-gh)             | 

# Project Resources and Documentation
Documentation can be found in the repository [wiki](https://github.com/SFDO-Community-Sprints/Geo-Reporting-PMM/wiki)

# Future Contributions 
- Flow for identifying Geographic Definitions that do not use shape data but are definied in a hierarchy
- Adding new fields to Geographic Definitions for hierarchical definition
- Setup documentation
