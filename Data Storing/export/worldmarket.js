const { Client } = require('pg');
const fs = require('fs');

const productsRawData = fs.readFileSync('/Users/nasywaanaa/Documents/nasywaa/ccc/5thsemester/Database/datastoring/Export/products.json');
const shippingInfoRawData = fs.readFileSync('/Users/nasywaanaa/Documents/nasywaa/ccc/5thsemester/Database/datastoring/Export/shipping_info.json');
const products = JSON.parse(productsRawData);
const shippingInfo = JSON.parse(shippingInfoRawData);

const dbConfig = {
  user: 'postgres',
  host: 'localhost',
  database: 'worldmarket',
  password: '961123',
  port: 5432,
};

// Fungsi untuk menghapus semua data dari tabel "products"
async function deleteProductsData(client) {
  try {
    await client.query('DELETE FROM products');
    console.log('Data has been deleted from the products table.');
  } catch (err) {
    console.error('Error while deleting products data:', err);
    throw err;
  }
}

// Fungsi untuk menghapus semua data dari tabel "shipping_info"
async function deleteShippingInfoData(client) {
  try {
    await client.query('DELETE FROM shipping_info');
    console.log('Data has been deleted from the shipping_info table.');
  } catch (err) {
    console.error('Error while deleting shipping_info data:', err);
    throw err;
  }
}

async function insertProduct(client, product) {
  const { Nama, Harga } = product;
  const query = 'INSERT INTO products (name, price) VALUES ($1, $2) ON CONFLICT (name) DO NOTHING';
  const values = [Nama, parseFloat(Harga)];
  await client.query(query, values);
}

async function insertShippingInfo(client, shipping) {
  const { Nama, 'Pick Up': pick_up, Arrive: arrival } = shipping;
  const query = 'INSERT INTO shipping_info (product_name, pick_up, arrival) VALUES ($1, $2, $3) ON CONFLICT (product_name) DO NOTHING';
  const values = [Nama, pick_up, arrival];
  await client.query(query, values);
}


// Fungsi utama untuk menyimpan data ke dalam database (termasuk menghapus data lama)
async function saveDataToDatabase() {
  const client = new Client(dbConfig);

  try {
    await client.connect();
    console.log('Connected to the database.');

    // Mulai transaksi
    await client.query('BEGIN');

    // Hapus data lama dari tabel-tabel
    await deleteProductsData(client);
    await deleteShippingInfoData(client);

    for (const product of products) {
      await insertProduct(client, product);
    }

    for (const shipping of shippingInfo) {
      await insertShippingInfo(client, shipping);
    }

    await client.query('COMMIT');
    console.log('Data has been successfully inserted/updated into PostgreSQL.');
  } catch (err) {
    await client.query('ROLLBACK');
    console.error('Error while processing data:', err);
  } finally {
    await client.end();
  }
}

saveDataToDatabase();
