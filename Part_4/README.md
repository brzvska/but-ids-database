### Part 4 - SQL script for creating advanced database schema objects

* *An SQL script that first creates the basic database schema objects and populates the tables with sample data (just like the script in step 2), and then defines or creates advanced constraints or database objects according to the specification requirements. In addition, the script will contain sample data manipulation statements and queries demonstrating the use of the above restrictions and objects of this script (eg to demonstrate the use of indexes, the script first calls EXPLAIN PLAN on a non-index query, then creates an index, and finally calls EXPLAIN PLAN on an index query; to demonstrate the database trigger, the data is manipulated, which invokes the given trigger, etc.).*
- *Specifically, this SQL script must contain all of the following:*
    - vytvoření alespoň dvou netriviálních databázových triggerů vč. jejich předvedení
    - creation of at least two non-trivial stored procedures incl. their demonstrations, in which the cursor must (together) occur at least once, exception handling and use of a variable with a data type referring to a table row or type (table_name.column_name% TYPE or table_name% ROWTYPE)
    - explicit creation of at least one index to help optimize query processing, while the relevant query affected by the index must also be specified, and the documentation describes how to use the index in this query (this can be combined with EXPLAIN PLAN, see below)
    - at least one use of EXPLAIN PLAN for a statement of the execution plan of a database query with a combination of at least two tables, an aggregation function and a GROUP BY clause, while the documentation must clearly describe how the execution of the execution plan statement will take place, incl. clarification of the means used to speed it up (eg use of an index, type of connection, etc.), and a way must be proposed to specifically speed up the query (eg by introducing a new index), the proposed method is implemented (eg created index ), EXPLAIN PLAN is repeated and its result is compared with the result before the proposed acceleration method is performed
    - definition of access rights to database objects for the second team member
    - created at least one materialized view belonging to the second team member and using tables defined by the first team member (access rights must already be defined), incl. SQL statements / queries showing how a materialized view works


### Part 5 - Documentation describing the final database schema

*Documentation describing individual points of the solution from the script in the 4th part incl. their justification (eg describes the output of the EXPLAIN PLAN statement without an index, the reason for creating the selected index, and the output of the EXPLAIN PLAN with an index, etc.).*
