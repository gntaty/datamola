--create tablespaces for diferent DW level 

CREATE TABLESPACE ts_p_attendances 
datafile '/oracle/u01/app/oracle/oradata/DCORCL/pdb_tgnezdilova/ts_p_attendances.dat'
SIZE 300M
 AUTOEXTEND ON NEXT 100M
 SEGMENT SPACE MANAGEMENT AUTO;

CREATE TABLESPACE SL_P_CONTRACTS
datafile '/oracle/u01/app/oracle/oradata/DCORCL/pdb_tgnezdilova/ts_p_contract .dat'
SIZE 150M 
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;
 
CREATE TABLESPACE ts_cleansing
datafile '/oracle/u01/app/oracle/oradata/DCORCL/pdb_tgnezdilova/ts_cleansing.dat'
SIZE 150M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;
 
 CREATE TABLESPACE dw_ts_data
datafile '/oracle/u01/app/oracle/oradata/DCORCL/pdb_tgnezdilova/dw_ts_data.dat'
SIZE 500M
 AUTOEXTEND ON NEXT 200M
 SEGMENT SPACE MANAGEMENT AUTO;
 
  CREATE TABLESPACE  ts_dims
datafile '/oracle/u01/app/oracle/oradata/DCORCL/pdb_tgnezdilova/ts_dims.dat'
SIZE 400M
 AUTOEXTEND ON NEXT 100M
 SEGMENT SPACE MANAGEMENT AUTO;