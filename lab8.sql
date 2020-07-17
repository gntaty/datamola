CREATE USER u_dw_admin
  IDENTIFIED BY "Admin"
    DEFAULT TABLESPACE ts_cleansing;

GRANT CONNECT,RESOURCE,CREATE VIEW TO u_dw_admin;
ALTER USER u_dw_admin QUOTA 150M ON ts_cleansing;
ALTER USER u_dw_user QUOTA 150 ON dw_ts_data;

CREATE USER u_dw_user
  IDENTIFIED BY "123"
    DEFAULT TABLESPACE ts_dims;

alter user u_dw_user quota 150 on ts_dims;

