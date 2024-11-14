import psycopg2

# Connect to PostgreSQL database
connection = psycopg2.connect(
    dbname="soap_factory",
    user="postgres",
    password="DUMI",
    host="127.0.0.1",
    port="5432"
)
cursor = connection.cursor()

# Open and read SQL-script
with open("database/soap_factory.sql", "r", encoding='UTF8') as sql_file:
    sql_script = sql_file.read()

# Execute SQL-script
cursor.execute(sql_script)

# Commit changes
connection.commit()

# Close cursor and connection
cursor.close()
connection.close()