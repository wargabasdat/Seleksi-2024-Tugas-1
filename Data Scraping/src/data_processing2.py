import pandas as pd
import numpy as np

def data_process_oli(da):
    """
    Membersihkan data dalam DataFrame untuk tabel Oli dan mengonversi tipe data sesuai kebutuhan.

    - Mengganti nilai kosong di kolom 'Spesifikasi' dengan NaN.
    - Menghapus "Spesifikasi SAE:" dari kolom 'Spesifikasi'.
    - Memastikan tipe data kolom sesuai dengan kebutuhan:
      - 'Kode_Produk' sebagai INT.
      - 'Spesifikasi', 'Nama_Produk', dan 'Kategori' sebagai VARCHAR (string).
      - 'Harga' sebagai NUMERIC (float).
    - Mengganti nilai kosong di setiap kolom dengan NaN sesuai dengan tipe data masing-masing.

    Args:
        da (pd.DataFrame): DataFrame yang akan dibersihkan.

    Returns:
        pd.DataFrame: DataFrame yang sudah dibersihkan dan dikonversi ke tipe data yang sesuai.
    """
    
    # Hapus nilai kosong di kolom 'Spesifikasi' dan pastikan kolom sebagai VARCHAR (string)
    if 'Spesifikasi' in da.columns:
        da['Spesifikasi'] = da['Spesifikasi'].replace('', np.nan)  # Replace empty strings with NaN
        da['Spesifikasi'] = da['Spesifikasi'].str.replace('Spesifikasi SAE:', '', regex=False).astype(str)

    # Pastikan kolom 'Kode_Produk' sebagai INT
    if 'Kode_Produk' in da.columns:
        da['Kode_Produk'] = da['Kode_Produk'].replace('', np.nan)  # Replace empty strings with NaN
        da['Kode_Produk'] = pd.to_numeric(da['Kode_Produk'], errors='coerce', downcast='integer')

    # Pastikan kolom 'Nama_Produk', 'Kategori' sebagai VARCHAR (string)
    if 'Nama_Produk' in da.columns:
        da['Nama_Produk'] = da['Nama_Produk'].replace('', np.nan)  # Replace empty strings with NaN
        da['Nama_Produk'] = da['Nama_Produk'].astype(str)
    if 'Kategori' in da.columns:
        da['Kategori'] = da['Kategori'].replace('', np.nan)  # Replace empty strings with NaN
        da['Kategori'] = da['Kategori'].astype(str)

    # Pastikan kolom 'Harga' sebagai NUMERIC (float)
    if 'Harga' in da.columns:
        da['Harga'] = da['Harga'].replace('', np.nan)  # Replace empty strings with NaN
        da['Harga'] = da['Harga'].str.replace('Rp', '', regex=False).str.replace(',', '', regex=False).astype(float)

    return da
