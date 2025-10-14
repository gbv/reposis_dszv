
# DSZV

## Installation Instructions

* run `mvn clean install`
* copy jar to ~/.mycore/(dev-)mir/lib/

* TODO: When migrating to higher mycore version add workflows back

## Migration

# 2018 -> 2025

Kommandos
```
create all objectinfo
update classification from uri resource:mycore-classifications/nameIdentifier.xml
update classification from uri resource:mycore-classifications/diniPublType2022.xml
update classification from uri resource:mycore-classifications/author_roles.xml
update classification from uri resource:mycore-classifications/derivate_types.xml
update classification from uri resource:classifications/DDC.xml
update classification from uri resource:classifications/marcrelator.xml
update classification from uri resource:classifications/mir_genres.xml
update classification from uri resource:classifications/mir_licenses.xml
update classification from uri resource:classifications/noteTypes.xml
update classification from uri resource:classifications/rfc5646.xml
update classification from uri resource:classifications/state.xml
migrate all derivates
harmonize derivates for all objects
repair metadata search of type mods
```

Poolprivileg anlegen: create-derivate für submitter
