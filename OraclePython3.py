import cx_Oracle
import sys

def Conexion_BD(usuario, password, dsn):
    try:
        # establecer conexión
        conexion = cx_Oracle.connect(usuario=usuario, password=password, dsn=dsn)

        print("Conectado a la base de datos:")
        return conexion
    except cx_Oracle.Error as e:
        print("No puedo conectar a la base de datos:", e)
        sys.exit(1)
