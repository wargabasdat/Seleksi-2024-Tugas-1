import pandas as pd
import numpy as np

def data_process(df):
    """
    Membersihkan data dalam DataFrame dan mengonversi tipe data sesuai kebutuhan.

    - Menghapus "Rp." dan tanda koma dari kolom 'Harga' dan mengonversi ke NUMERIC (float).
    - Menghapus "Kategori: " dari kolom 'Kategori' dan mengonversi ke VARCHAR.
    - Menghapus "Produk ini bisa digunakan oleh motor:" dari kolom 'Motor Implementasi' dan mengonversi ke TEXT.
    - Mengganti nilai kosong di kolom 'Berat', 'Warna', dan 'Dimensi' dengan NaN dan mengonversi ke VARCHAR.
    - Mengisi nilai kosong di setiap kolom dengan NaN sesuai dengan tipe data masing-masing.

    Args:
        df (pd.DataFrame): DataFrame yang akan dibersihkan.

    Returns:
        pd.DataFrame: DataFrame yang sudah dibersihkan dan dikonversi ke tipe data yang sesuai.
    """
    
    # Hapus "Rp" dan tanda koma dari kolom 'Harga' dan konversi ke float (NUMERIC)
    if 'Harga' in df.columns:
        df['Harga'] = df['Harga'].replace('', np.nan)  # Replace empty strings with NaN
        df['Harga'] = df['Harga'].str.replace('Rp', '', regex=False).str.replace(',', '', regex=False).astype(float)

    # Hapus "Kategori: " dari kolom 'Kategori' dan pastikan tipe data VARCHAR
    if 'Kategori' in df.columns:
        df['Kategori'] = df['Kategori'].replace('', np.nan)  # Replace empty strings with NaN
        df['Kategori'] = df['Kategori'].str.replace('Kategori: ', '', regex=False).astype(str)

    # Hapus "Produk ini bisa digunakan oleh motor:" dari kolom 'Motor Implementasi' dan pastikan tipe data TEXT
    if 'Motor Implementasi' in df.columns:
        df['Motor Implementasi'] = df['Motor Implementasi'].replace('', np.nan)  # Replace empty strings with NaN
        df['Motor Implementasi'] = df['Motor Implementasi'].str.replace('Produk ini bisa digunakan oleh motor:', '', regex=False).astype(str)

    # Ganti nilai kosong di kolom 'Berat', 'Warna', dan 'Dimensi' dengan NaN dan pastikan tipe data VARCHAR
    columns_to_replace = ['Berat', 'Warna', 'Dimensi']
    for col in columns_to_replace:
        if col in df.columns:
            df[col] = df[col].replace('', np.nan).astype(str)

    # Convert all columns to appropriate data types and handle empty values
    for column in df.columns:
        # Check if the column is numeric
        if df[column].dtype.kind in 'iufc':  # Integer, unsigned, float, complex
            df[column] = pd.to_numeric(df[column], errors='coerce')
        else:
            # If not numeric, ensure it's treated as a string
            df[column] = df[column].astype(str)

    return df
