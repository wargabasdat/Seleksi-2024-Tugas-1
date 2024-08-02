import pandas as pd
import numpy as np

def data_process_discount_products(df):
    """
    Membersihkan data dalam DataFrame untuk tabel produk diskon.

    - Menghapus kolom yang tidak relevan, hanya menyimpan kolom:
      - 'Nama Produk' sebagai VARCHAR (string).
      - 'Kategori' sebagai VARCHAR (string).
      - 'Harga_Sebelumnya' dan 'Harga_Sekarang' sebagai NUMERIC (float).
    - Mengganti nilai kosong di setiap kolom dengan NaN sesuai dengan tipe datanya.

    Args:
        df (pd.DataFrame): DataFrame yang akan dibersihkan.

    Returns:
        pd.DataFrame: DataFrame yang sudah dibersihkan dan dikonversi ke tipe data yang sesuai.
    """
    
    # Hanya menyimpan kolom yang relevan
    relevant_columns = ['Nama Produk', 'Kategori', 'Harga_Sebelumnya', 'Harga_Sekarang']
    df = df[relevant_columns]

    # Pastikan kolom 'Nama Produk' sebagai VARCHAR (string)
    if 'Nama Produk' in df.columns:
        df['Nama Produk'] = df['Nama Produk'].replace('', np.nan).astype(str)

    # Pastikan kolom 'Kategori' sebagai VARCHAR (string)
    if 'Kategori' in df.columns:
        df['Kategori'] = df['Kategori'].replace('', np.nan).astype(str)

    # Pastikan kolom 'Harga_Sebelumnya' dan 'Harga_Sekarang' sebagai NUMERIC (float)
    if 'Harga_Sebelumnya' in df.columns:
        df['Harga_Sebelumnya'] = df['Harga_Sebelumnya'].replace('', np.nan)  # Replace empty strings with NaN
        df['Harga_Sebelumnya'] = df['Harga_Sebelumnya'].astype(float)

    if 'Harga_Sekarang' in df.columns:
        df['Harga_Sekarang'] = df['Harga_Sekarang'].replace('', np.nan)  # Replace empty strings with NaN
        df['Harga_Sekarang'] = df['Harga_Sekarang'].astype(float)

    return df