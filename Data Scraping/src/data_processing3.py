import pandas as pd
import numpy as np

def data_process_motor(da):
    """
    Membersihkan data dalam DataFrame untuk tabel Motor.

    - Mengganti nilai kosong di kolom 'Fitur' dengan NaN dan memastikan kolom sebagai TEXT.
    - Memastikan tipe data kolom sesuai dengan kebutuhan:
      - 'Kode_Produk' sebagai INT.
      - 'Fitur' sebagai TEXT.
      - 'Nama_Produk' dan 'Kategori' sebagai VARCHAR (string) jika kolom tersebut ada.
      - 'Harga' sebagai NUMERIC (float) jika kolom tersebut ada.

    Args:
        da (pd.DataFrame): DataFrame yang akan dibersihkan.

    Returns:
        pd.DataFrame: DataFrame yang sudah dibersihkan dan dikonversi ke tipe data yang sesuai.
    """
    
    # Ganti nilai kosong di kolom 'Fitur' dengan NaN dan pastikan kolom sebagai TEXT
    if 'Fitur' in da.columns:
        da['Fitur'] = da['Fitur'].replace('', np.nan).astype(str)

    # Pastikan kolom 'Kode_Produk' sebagai INT
    if 'Kode_Produk' in da.columns:
        da['Kode_Produk'] = da['Kode_Produk'].replace('', np.nan)  # Replace empty strings with NaN
        da['Kode_Produk'] = pd.to_numeric(da['Kode_Produk'], errors='coerce', downcast='integer')

    # Pastikan kolom 'Nama_Produk' dan 'Kategori' sebagai VARCHAR (string) jika ada
    if 'Nama_Produk' in da.columns:
        da['Nama_Produk'] = da['Nama_Produk'].replace('', np.nan).astype(str)
    if 'Kategori' in da.columns:
        da['Kategori'] = da['Kategori'].replace('', np.nan).astype(str)

    # Pastikan kolom 'Harga' sebagai NUMERIC (float) jika ada
    if 'Harga' in da.columns:
        da['Harga'] = da['Harga'].replace('', np.nan)  # Replace empty strings with NaN
        da['Harga'] = da['Harga'].str.replace('Rp', '', regex=False).str.replace(',', '', regex=False).astype(float)

    return da
