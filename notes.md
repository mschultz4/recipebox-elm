 # Insert rows containing foreign key relationship

For a little side project/ learning experiment I am working on, I have a simple relationship: three tables, one sort of parent table and two children both with foreign keys referencing the parent's id.  Something like this:

-table one
|id_one |  title | notes|
|-------+--------+------|
|  1    |  bob   | hi   |

-table two
| id_two | id_one | notes|
|--------+--------+------|
|    1   |    1   | bye  |

-table three    
| id_three |   id_one | notes|
|----------+----------+------|
|    1     |    1     | bye  |

Now I need to update all three.  Some constraints:
1. only one trip to the database.
2. If one update fails, the others can't succeed (basically a transaction).
3. Needs to accept parameters in node-postgres.

Just because
1. Want the query to be in a separate sql file. 
