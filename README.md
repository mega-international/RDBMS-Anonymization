# RDBMS-Anonymization

This utility is a set of SQL Server scripts that allows to anonymize an HOPEX repository before sending it to MEGA technical support.

>**Important**
>
>This is the step by step process to anonymize a database.
>Do not try to launch the process without reading this first.

This utility replaces all values of text attributes (string or varchar) with lorem ipsum text of the same length. There is no way to revert the data back.

## STEP 1 : MICROSOFT SQL Server user account server role and permission

The utility uses a bulk to add attribute that you want to include or exclude on top of the list already made.
The login has to have a server role allowing it : **bulkadmin** or **sysadmin**

Because the utility will overwrite a good part of your database, it only works if the **database name's** end with **'_ANONYME'**.

You must be able to modify your database name. you will work on a copy of your original database.

1. Backup the Data Database and the system Database.
1. Restore them with a name that ends with '_ANONYME'

## STEP 2 : FILE ACCESS permissions

The files need to be place in C:\temp\

| File Name | Comment | File Status |
|---|---|---|
| Rand.sql | In case you do not have a random function implemented | Do not modify |
| Lipsum.sql | This is a function that lorem ipsum a given text | Do not modify |
| Anonymisation.sql | The script that will anonymize you database | Do not modify |
| ExclusionInclusion.txt | List of attributes to exclude (0) or include (1) | |
| SystemdBName.txt | Name of the System database. PUT THE CORRECT systemDBName before going to step 5 | |

## STEP 4 : ADDING FUNCTION

1. Open a command
2. If the function Rand() wasn’t integrated write :

```dos
SQLCMD -S ServerName -U Login -P password -i c:\temp\Rand.sql
```

3. If the function Lipsum wasn’t integrated write :

```dos
SQLCMD -S ServerName -U Login -P password -i c:\temp\lipsum.sql
```

## STEP 5: LAUNCHING ANONYMIZATION

Final step : You are going to launch the Anonymisation procedure

 Still in your command, write

```dos
SQLCMD -S ServerName -U Login -P password -d DATABASE_ANONYME -i c:\temp\Anonymisation.sql
```

> **Note**
> If you didn’t rename the database you wanted to anonymize with a name ending by **_ANONYME** as said in **step 1**, The script will do nothing
