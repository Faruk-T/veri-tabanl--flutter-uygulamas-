from flask import Flask, request, jsonify
from flask_cors import CORS
import pyodbc

app = Flask(__name__)
CORS(app)

# Access bağlantısı
conn_str = r'DRIVER={Microsoft Access Driver (*.mdb, *.accdb)};DBQ=C:\\Users\\enest\\flutterProjesi\\Database2.accdb;'
conn = pyodbc.connect(conn_str)
cursor = conn.cursor()

# Araç Ekle
@app.route('/add_car', methods=['POST'])
def add_car():
    data = request.json
    cursor.execute("""
        INSERT INTO servisegelenaraclar 
        (AracAdi, AracMarka, AracModel, UretimYili, Plaka) 
        VALUES (?, ?, ?, ?, ?)
    """, data['AracAdi'], data['AracMarka'], data['AracModel'], data['UretimYili'], data['Plaka'])
    conn.commit()
    return jsonify({'message': 'Araç eklendi.'})

# Araç Listele
@app.route('/list_cars', methods=['GET'])
def list_cars():
    cursor.execute("SELECT * FROM servisegelenaraclar")
    rows = cursor.fetchall()
    cars = []
    for row in rows:
        cars.append({
            "AracID": row.AracID,
            "AracAdi": row.AracAdi,
            "AracMarka": row.AracMarka,
            "AracModel": row.AracModel,
            "UretimYili": str(row.UretimYili),
            "Plaka": row.Plaka
        })
    return jsonify(cars)

# Araç Sil
@app.route('/delete_car/<int:car_id>', methods=['DELETE'])
def delete_car(car_id):
    cursor.execute("DELETE FROM servisegelenaraclar WHERE AracID = ?", car_id)
    conn.commit()
    return jsonify({'message': 'Araç silindi.'})

if __name__ == '__main__':
    app.run(debug=True)
