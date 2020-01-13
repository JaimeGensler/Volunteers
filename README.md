# Volunteer Tracker

#### _A website to track volunteers assigned to different projects! - Jan. 12, 2020_

#### By _Jaime Gensler_


## Description
_Volunteer Tracker will allow you to create new projects and assign volunteers to those projects. Both volunteers and projects can be created, read, updated, and deleted! Information is stored in a database, and as such will be saved across uses of site._

| SPEC                                   | EXAMPLE INPUT                | EXAMPLE OUTPUT                |
|----------------------------------------|------------------------------|-------------------------------|
| Users can create a project             | New Project => 'Teach Code'  | 'Teach Code!'                 |
| Users can update projects              | 'Teach Code' => 'Teach Ruby' | 'Teach Ruby', same volunteers |
| Users can delete projects              | Delete 'Teach Ruby'          | No 'Teach Ruby'               |
| Same CRUD functionality for Volunteers | "Jaime Gensler, Teach Ruby"  | Teaching Ruby: Jaime Gensler  |

## Setup/Installation Requirements

#### Cloning:
* _Clone this github repository_
* _CD into the repository_
* _Run 'gem install bundler'_
* _Run 'bundle'_
* _Run 'createdb volunteer_tracker'_
* _Run 'psql [volunteer_tracker] < database_backup.sql'_
* _Run 'createdb -T volunteer_tracker volunter_tracker_test_
* _Run ruby app.rb_
* _Enjoy!_


## Support and contact details

_For questions, comments, complaints, or confessions, please reach out to me at: <jaimegensler0@gmail.com>_


## Technologies Used

* _Ruby_
* _bundler_
* _rspec_
* _pry_
* _sinatra_
* _psql_


### License

This software is licensed under the MIT License.

Copyright (c) 2019 **_Jaime Gensler_**
