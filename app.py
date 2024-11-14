import streamlit as st
import pandas as pd
import psycopg2

def INSERT_DB(cur_df, ed_df, table, connection, cursor):
    try:
        if ed_df.shape[0] > cur_df.shape[0]:
            string_q = f"INSERT INTO factory.{table}"
            string_q += " ("
            string_q += ", ".join(cur_df.columns)
            string_q += ") VALUES "
            string_add = [" " for i in range(cur_df.shape[0], ed_df.shape[0])]
            data = []
            for i in range(cur_df.shape[0], ed_df.shape[0]):
                data += [i if type(i) is str else int(i) for i in ed_df.values[i]]
                string_add[i-cur_df.shape[0]] = "("
                string_add[i-cur_df.shape[0]] += ", ".join(["%s" for i in ed_df.values[i]])
            string_q += "), ".join(string_add)
            string_q += ")"
            print(string_q)
            print(data)
            cursor.execute(string_q, data)
            connection.commit()
    except Exception as e:
            st.error(f"Error executing: '{string_q}': {e}")

def UPDATE_DB(cur_df, ed_df, table, connection, cursor):
    try:
        if not edited_df.equals(df):
            string_q = f"UPDATE factory.{table} SET "
            string_q += " = %s, ".join(cur_df.columns[1:])
            string_q += " = %s "
            string_q += f" WHERE {cur_df.columns[0]} = %s;"
            for i in range(cur_df.shape[0]):
                if ed_df.values[i].tolist() != cur_df.values[i].tolist():
                    data = [i if type(i) is str else int(i) for i in ed_df.values[i][1:]]
                    print(ed_df.values[i][0])
                    data.append(int(ed_df.values[i][0]))
                    print(string_q)
                    print(data)
                    cursor.execute(string_q, data)                
            connection.commit()
    except Exception as e:
        st.error(f"Error executing: '{string_q}': {e}")

def DELETE_DB(cur_df, ed_df, table, connection, cursor):
    try:
        if ed_df.shape[0] < cur_df.shape[0]:
            for i in range(cur_df.shape[0]):
                if not (cur_df[cur_df.columns[0]][i] in ed_df[cur_df.columns[0]].tolist()):
                    print(cur_df[cur_df.columns[0]][i])
                    print(ed_df[cur_df.columns[0]][:])
                    print(int(cur_df[cur_df.columns[0]][i]))
                    cursor.execute(f"DELETE FROM factory.{table} WHERE {cur_df.columns[0]} = %s;", (int(cur_df[cur_df.columns[0]][i]),))
                    connection.commit()
    except Exception as e:
        st.error(f"Error executing: '{'DELETE'}': {e}")

connection = psycopg2.connect(
    dbname="soap_factory",
    user="postgres",
    password="DUMI",
    host="127.0.0.1",
    port="5432"
)
cursor = connection.cursor()

# Get list of tables in factory
cursor.execute("SELECT table_name FROM information_schema.tables WHERE table_schema='factory' ORDER BY table_name;")
tables = cursor.fetchall()
tables = [table[0] for table in tables]

# List of tables to select
selected_table = st.selectbox("Choose a table", tables)

# Table view
cursor.execute(f"SELECT * FROM factory.{selected_table};")
data = cursor.fetchall()
columns = [desc[0] for desc in cursor.description]
df = pd.DataFrame(data, columns=columns)
# st.dataframe(df)

edited_df = st.data_editor(df, num_rows="dynamic")

print(edited_df.shape[0] - df.shape[0])
if edited_df.shape[0] > df.shape[0]:
    if st.button("INSERT"):
        INSERT_DB(df, edited_df, selected_table, connection, cursor)
elif not edited_df.equals(df) and edited_df.shape[0] == df.shape[0]:
    if st.button("UPDATE"):
     UPDATE_DB(df, edited_df, selected_table, connection, cursor)
elif edited_df.shape[0] < df.shape[0]:
    if st.button("DELETE"):
        DELETE_DB(df, edited_df, selected_table, connection, cursor)

# Enter the SQL query
query = st.text_area("Enter SQL-query", f"SELECT * FROM factory.{selected_table};")

# Button to execute entered SQL query
if st.button("Execute SQL-query"):
    try:
        cursor.execute(query)
        result_data = cursor.fetchall()
        result_columns = [desc[0] for desc in cursor.description]
        result_df = pd.DataFrame(result_data, columns=result_columns)
        st.dataframe(result_df)
    except Exception as e:
        st.error(f"Error executing SQL-query: {e}")

# Predefined queries
predefined_queries = {
    "Tranzactie tip Purchase": f"SELECT transaction_id, transaction_date, partner_id, item_type, item_id, quantity, transaction_amount "
                               f"FROM factory.transactions WHERE transaction_type = 'Purchase' AND transaction_date = '2024-02-22';",
    "Cautarea tranzactiei id": f"SELECT transaction_id, transaction_date, item_type, item_id, quantity, transaction_amount FROM factory.transactions "
                 f"WHERE partner_id = (SELECT partner_id FROM factory.transactions WHERE partner_id = 3 LIMIT 1);",
    "Grupare dupa tranzactii si pret": f"SELECT item_type FROM factory.transactions GROUP BY item_type HAVING SUM(transaction_amount) > 50;",
    "Valoare MAX pentru 'Purchase' per partener ": f"SELECT partner_id, MAX(transaction_amount) AS max_transaction FROM factory.transactions "
                 f"WHERE transaction_type = 'Purchase' GROUP BY partner_id;",
    "Cantitate medie tranzactionata per produs": f"SELECT transaction_id, transaction_date, partner_id, item_type, item_id, quantity, transaction_amount "
                 f"FROM factory.transactions t1 WHERE quantity > (SELECT AVG(quantity) FROM factory.transactions t2 "
                 f"WHERE t1.item_type = t2.item_type);",


    "Detalii comanda": f"SELECT o.order_id,o.order_date,o.quantity,o.total_amount,UPPER(e.full_name) AS employee_name,e.position "
                 f"AS employee_position,p.partner_name,p.partner_type,i.item_name,i.price "
                 f"FROM factory.orders o JOIN factory.employees e ON o.employee_id = e.employee_id "
                 f"JOIN factory.partners p ON o.partner_id = p.partner_id "
                 f"JOIN factory.items i ON o.item_id = i.item_id;",
    "Detalii tranzactii": f"SELECT t.transaction_id, t.transaction_date, t.quantity,t.transaction_amount,t.transaction_type,"
                          f"p.partner_name,p.partner_type,i.item_name,i.price,i.item_description "
                 f"FROM factory.transactions t "
                 f"JOIN factory.partners p ON t.partner_id = p.partner_id "
                 f"JOIN factory.items i ON t.item_id = i.item_id;",

}

# Buttons to execute predefined queries
for query_name, query_text in predefined_queries.items():
    if st.button(query_name):
        try:
            cursor.execute(query_text)
            result_data = cursor.fetchall()
            result_columns = [desc[0] for desc in cursor.description]
            result_df = pd.DataFrame(result_data, columns=result_columns)
            st.dataframe(result_df)
        except Exception as e:
            st.error(f"Error executing: '{query_name}': {e}")

# Close the connection
cursor.close()
connection.close()


