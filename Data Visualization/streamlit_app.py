import streamlit as st
import pandas as pd
import plotly.express as px
import plotly.graph_objects as go
import plotly.io as pio
from plotly.subplots import make_subplots
import mariadb
import sys
from numerize import numerize


def tryConnect():
    connection = None
    try:
        connection = mariadb.connect(
            host="localhost",
            user="root",
            passwd="1234",
            database="basdat",
        )
        print("Connection to MySQL DB successful")
    except mariadb.Error as e:
        print(f"The error '{e}' occurred")
        sys.exit(1)
    return connection

def execute_query(connection, query, var):
    cursor = connection.cursor()
    try:
        cursor.execute(query, var)
        print("Query executed successfully")
    except mariadb.Error as e:
        print(f"The error '{e}' occurred")

def execute_read_query(connection, query, var):
    cursor = connection.cursor()
    
    try:
        cursor.execute(query, var)
        return cursor
    except mariadb.Error as e:
        print(f"The error '{e}' occurred")
        return cursor

def card(connection):
    totalSeries = execute_read_query(connection, "SELECT Count(*) as count FROM Series", ())
    totalChapter = execute_read_query(connection, "SELECT SUM(total_chapter) FROM Series", ())
    averageRating = execute_read_query(connection, "SELECT AVG(rating) as avg FROM Series", ())
    highestRating = execute_read_query(connection, "SELECT rating as avg FROM Series order by rating desc limit 1", ())
    lowestRating = execute_read_query(connection, "SELECT rating as avg FROM Series order by rating asc limit 1", ())
    highestRating = list(highestRating)[0][0]
    lowestRating = list(lowestRating)[0][0]
    highestRatingNovel = execute_read_query(connection, "SELECT seriesName FROM Series where rating = ?", (highestRating,))
    lowestRatingNovel = execute_read_query(connection, "SELECT seriesName FROM Series where rating = ?", (lowestRating,))
    genreCount = pd.read_sql("SELECT COUNT(*) as count FROM Genres", connection)
    tagCount = pd.read_sql("SELECT COUNT(*) as count FROM Tags", connection)
    col1,col2, col3, col4, col5 = st.columns(5, gap='small')
    with col1:
        st.info("Total Series", icon='📖')
        st.metric(label='Total:', value=(str(list(totalSeries)[0][0]) + " series"))
    with col2:
        st.info("Total Chapter", icon='📜')
        st.metric(label='Total:', value=(str(numerize.numerize((list(totalChapter)[0][0]))) + " chapter"))
    with col3:
        st.info("Average Rating", icon='⭐')
        st.metric(label="Average:", value=str(numerize.numerize(list(averageRating)[0][0])) + " stars", help="Highest Rating: " + str(numerize.numerize(highestRating)) + " stars → " + list(highestRatingNovel)[0][0] + "\n\nLowest Rating: " + str(numerize.numerize(lowestRating)) + " stars → " + list(lowestRatingNovel)[0][0])
    with col4:
        st.info("Total Genres", icon='🎭')
        st.metric(label="Total:", value=str(genreCount.iloc[0,0]) + " genres")  
    with col5:
        st.info("Total Tags", icon='🏷️')
        st.metric(label="Total:", value=str(tagCount.iloc[0,0]) + " tags")    

st.set_page_config(page_title='Dashboard Basdat', layout='wide', initial_sidebar_state='expanded')
with open('style.css') as f:
    st.markdown(f'<style>{f.read()}</style>', unsafe_allow_html=True)

# sidebar
st.sidebar.markdown('# OHL Basdat `version 1`')
with st.sidebar:
    st.markdown("# Data scraped from https://novelbin.me/sort/novelbin-popular")
    st.markdown("""
# Insight yang Didapatkan

Kita dapat mengetahui beberapa informasi penting, seperti jumlah *series*, jumlah *chapter*, rata-rata *rating*, jumlah *genre*, serta jumlah *tag* dari novel-novel yang berhasil di-*scraped*.

- # Distribution of Genres and Tags
    Dari *bar chart* di samping terlihat bahwa novel dengan genre *Fantasy* memiliki jumlah yang paling banyak dan diikuti dengan novel dengan genre *Action*, kemudian novel dengan genre *Romance*. <br> <br>
    Terlihat juga bahwa novel yang memiliki *tag Male protagonist* memiliki jumlah yang paling banyak, diikuti oleh novel dengan *tag Weak to strong*. Selain itu, terlihat juga bahwa novel yang tidak memiliki *tag* sama sekali memiliki jumlah yang cukup banyak dan menempati posisi ke-3.

- # Series Count by Year of Publishing
    Dari *line chart* di samping terlihat peningkatan jumlah novel yang masuk ke dalam *Most Popular List* berdasarkan *novelbin.me* seiring berjalannya waktu. Jumlah tersebut mengalami *peak*-nya pada tahun 2021 dan mengalami penurunan pada tahun-tahun berikutnya. Terdapat beberapa faktor yang mungkin mempengaruhi penurunan tersebut, seperti menurunnya kualitas novel-novel yang baru keluar. Atau faktor lain yang mungkin adalah novel yang baru keluar memerlukan waktu untuk berkembang dan dikenal para pembaca untuk masuk ke dalam *Most Popular List*.

- # Pie Chart of Series Status
    Berdasarkan *pie chart* di samping terlihat bahwa sebagian besar novel yang ada pada *Most Popular List* masih berstatus Ongoing dan sisanya berstatus Completed. 
                
- # Top 10 Author with Most Series & Top 10 Author with Most Chapter
    Pada *bar chart* yang ada di sebelah kiri terlihat 10 nama author dengan jumlah novel terbanyak, sedangkan pada *bar chart* yang ada di sebelah kanan terlihat 10 nama author dengan jumlah chapter terbanyak. Dari kedua *chart* tersebut hanya ada 6 nama author yang beririsan. Hal ini menunjukkan bahwa author dengan jumlah series yang banyak belum tentu memiliki jumlah chapter yang banyak, begitu juga sebaliknya.
                
- # Average Rating of Each Genre and Number of Each Genre by Year of Publishing
    Anda bisa memilih genre yang ingin ditampilkan pada bagian `Select Genre:` atau men-*double click genre* yang ada di *legend* di sebelah kanan masing-masing *graph* untuk hanya menampilkan genre tersebut.            

    Dari *line chart* tersebut kita dapat melihat perkembangan rata-rata rating dan jumlah novel dengan genre tersebut untuk setiap *Year of Publishing*. Hal ini dapat digunakan untuk melihat perkembangan *trend* dari masing-masing genre tiap tahunnya. <br> <br>
    Kita dapat melihat pada tahun 2022-2023 terdapat peningkatan rata-rata rating novel dengan genre *Tragedy, Romance, Slice of Life, Adventure, Reincarnation, Mystery, Fantasy, Video Games*, dan *Xuanhuan*. Namun, pada rentang tahun yang sama, kebanyakan genre tersebut mengalami penurunan jumlah novel. <br><br>
    Hal ini mungkin saja disebabkan oleh beberapa hal, salah satunya mungkin saja banyak novel dengan genre tersebut yang tidak masuk ke dalam *Most Popular List* karena baru saja *publish* sehingga hanya yang benar-benar bagus (rating tinggi) yang masuk ke dalam *List* sehingga *average rating* untuk genre tersebut meningkat. 

[Link to Streamlit documentation](https://docs.streamlit.io/)<br>
[Link to Plotly documentation](https://plotly.com/python/)
""", unsafe_allow_html=True)

# home
st.header("Dashboard Novel in novelbin.me")
connection = tryConnect()
st.subheader("Key Information About The Data Scraped")
card(connection)
st.divider()
st.subheader('Some Graph and Chart')

with st.expander("**DISTRIBUTIONS OF GENRES AND TAGS**", expanded=True):
    def genreTagDist(connection):
        seriesGenre = pd.read_sql("SELECT genre, count(genre) FROM Series_Genre GROUP BY genre ORDER BY count(genre) desc LIMIT 30", connection)
        seriesTags = pd.read_sql("SELECT tag, count(tag) FROM Series_Tag GROUP BY tag ORDER BY count(tag) desc LIMIT 30", connection)
        fig = make_subplots(rows=1, cols=2, shared_yaxes=True, subplot_titles=('Top 30 Genres by Counts', 'Top 30 Tags by Counts'),  horizontal_spacing=0.05)
        fig.add_trace(go.Bar(x=seriesGenre['genre'], y=seriesGenre['count(genre)'], name='Genres',hovertemplate='<b>Genre:</b> %{x}<br><b>Count:</b> %{y}<extra></extra>'),
        row=1, col=1)
        # Add tag bar plot
        fig.add_trace(
            go.Bar(x=seriesTags['tag'], y=seriesTags['count(tag)'], name='Tags',hovertemplate='<b>Tag:</b> %{x}<br><b>Count:</b> %{y}<extra></extra>'),
            row=1, col=2, 
        )
        fig.update_layout(
        title_text='Genre and Tag Counts',
        xaxis_title='Genre',
        yaxis_title='Count',
        xaxis2_title='Tag',
        height=600,  
        width=1000, 
        hoverlabel=dict(
            font_size=16,  
            font_family='Arial, sans-serif', 
            font_color='black',
        ),
        xaxis=dict(
            dict(tickangle=-45),
            tickfont=dict(
                size=16,
                # color='black',
                family='Arial, sans-serif',
                weight='bold'
            )
        ),
        xaxis2=dict(
            dict(tickangle=-45),
            tickfont=dict(
                size=16,
                # color='black',
                family='Arial, sans-serif',
                weight='bold'
            )
        ),
        yaxis=dict(
            tickfont=dict(
                size=16,
                # color='black',
                family='Arial, sans-serif',
                weight='bold'
            )
        ),
        showlegend=True,
        xaxis_title_font=dict(size=16, family="Arial, sans-serif", weight='bold'),
        xaxis2_title_font=dict(size=16, family="Arial, sans-serif", weight='bold'),
        yaxis_title_font=dict(size=16, family="Arial, sans-serif", weight='bold'),
        title={
            'x': 0.5,  
            'xanchor': 'center',
            'font': dict(size=16, family="Arial, sans serif")
        },
        )
        st.plotly_chart(fig,use_container_width=True)
    genreTagDist(connection)

st.divider()

# series count per year
def seriesCountYear(connection):
    seriesCount = pd.read_sql("SELECT count(seriesName) as count, year FROM Series GROUP BY year HAVING year <> 0 ORDER BY year asc", connection)
    figSeriesCount = px.line(seriesCount, seriesCount['year'], seriesCount['count'], orientation="v", title="Series Count by Year of Publishing", template='plotly_white', markers=True)
    figSeriesCount.update_traces(
        line=dict(
            color='red',  
            width=2       
        ),
        hovertemplate='<b>Year:</b> %{x}<br><b>Count:</b> %{y}<extra></extra>'
    )
    figSeriesCount.update_layout(
        xaxis_title='Year of Publishing', 
        yaxis_title='Series Count', 
        hoverlabel=dict(
            font_size=16, 
            font_family='Arial, sans-serif', 
            font_color='black',
        ),
        xaxis=dict(
            tickfont=dict(
                size=16,
                # color='black',
                family='Arial, sans-serif',
                weight='bold'
            )
        ),
        yaxis=dict(
            tickfont=dict(
                size=16,
                # color='black',
                family='Arial, sans-serif',
                weight='bold'
            )
        ),
        xaxis_title_font=dict(size=16, family="Arial, sans-serif", weight='bold'),
        yaxis_title_font=dict(size=16, family="Arial, sans-serif", weight='bold'),
        title={
            'x': 0.5,  
            'xanchor': 'center',
            'font': dict(size=16, family="Arial, sans serif")
        }
    )
    st.plotly_chart(figSeriesCount, use_container_width=True)

def pieChart(connection):
    data = pd.read_sql("SELECT status, count(*) FROM Series GROUP BY status", connection)
    fig = px.pie(data, names='status', values='count(*)', hover_data=['status', 'count(*)'], template='plotly')
    # st.write(fig.data)
    fig.update_traces(
        hovertemplate='<b>Status:</b> %{customdata[0][0]}<br><b>Count:</b> %{customdata[0][1]}<br><extra></extra>',
    )
    # st.write(fig.data)
    fig.update_layout(
        hoverlabel=dict(
            font_size=16,   
            font_family='Arial, sans-serif', 
            font_color='black',
        ),
        title={
            'text': "Pie Chart of Series Status",
            'y':0.98,
            'x':0.5,
            'xanchor': 'center',
            'yanchor': 'top',
            'font': {
                'size': 24,
                'color': 'black',
                'family': 'Arial',
                'weight': 'bold',
            }
        },
        legend=dict(
            title=dict(
                text='Regions',
                font=dict(
                    size=18, 
                    color='black',
                    family='Arial'
                )
            ),
            font=dict(
                size=16,
                color="black",
                family="Arial"
            ),
            x=0.80,
            y=1.0,
            xanchor='center',
            yanchor='top',
            bgcolor='rgba(255, 255, 255, 0.5)',
            bordercolor='black',
            borderwidth=2,
        )
    )
    fig.update_layout(legend_y=0.9)
    fig.update_traces(textinfo='percent+label', textposition='inside', textfont_size=18)
    st.plotly_chart(fig, use_container_width=True)
col1, col2 = st.columns(2)
with col1:
    seriesCountYear(connection)
with col2:
    pieChart(connection)

st.divider()

# top 10 author with the most series
def authorSeriesDraw(connection):
    authorSeries = pd.read_sql("SELECT author, count(seriesName) as count FROM Series GROUP BY author ORDER BY count desc LIMIT 10", connection)
    figAuthorSeries = px.bar(authorSeries, x="author", y="count", title="Top 10 Author with The Most Series")
    figAuthorSeries.update_traces(
        hovertemplate='<b>Author:</b> %{x}<br><b>Series Count:</b> %{y}<extra></extra>'
    )
    figAuthorSeries.update_layout(
        xaxis_title='Author', 
        yaxis_title='Series Count',
        hoverlabel=dict(
            font_size=16,  
            font_family='Arial, sans-serif',
            font_color='black',
        ),
        xaxis_title_font=dict(size=16, family="Arial, sans-serif", weight='bold'),
        yaxis_title_font=dict(size=16, family="Arial, sans-serif", weight='bold'),
        title={
            'x': 0.5,  
            'xanchor': 'center',
            'font': dict(size=16, family="Arial, sans serif")
        },
        xaxis=dict(
            tickfont=dict(
                size=16,
                # color='black',
                family='Arial, sans-serif',
                weight='bold'
            )
        ),
        yaxis=dict(
            tickfont=dict(
                size=16,
                # color='black',
                family='Arial, sans-serif',
                weight='bold'
            )
        ),
    )
    st.plotly_chart(figAuthorSeries, use_container_width=True)
def authorChapterDraw(connection):
    AuthorChapter = pd.read_sql("SELECT author, sum(total_chapter) as sum FROM Series GROUP BY author ORDER BY sum desc LIMIT 10", connection)
    figAuthorChapter = px.bar(AuthorChapter, x="author", y="sum", title="Top 10 Author with The Most Chapter", color_discrete_sequence=['#2596be'])
    figAuthorChapter.update_traces(
        hovertemplate='<b>Author:</b> %{x}<br><b>Chapter Count:</b> %{y}<extra></extra>'
    )
    figAuthorChapter.update_layout(
        xaxis_title='Author', 
        yaxis_title='Total Chapter',
        hoverlabel=dict(
            font_size=16,  
            font_family='Arial, sans-serif',
            font_color='black',
        ),
        xaxis_title_font=dict(size=16, family="Arial, sans-serif", weight='bold'),
        yaxis_title_font=dict(size=16, family="Arial, sans-serif", weight='bold'),
        title={
            'x': 0.5,  
            'xanchor': 'center',
            'font': dict(size=16, family="Arial, sans serif")
        },
        xaxis=dict(
            tickfont=dict(
                size=14,
                # color='black',
                family='Arial, sans-serif',
                weight='bold'
            )
        ),
        yaxis=dict(
            tickfont=dict(
                size=16,
                # color='black',
                family='Arial, sans-serif',
                weight='bold'
            )
        ),
    )
    st.plotly_chart(figAuthorChapter, use_container_width=True)
col1, col2 = st.columns(2)
with col1:
    authorSeriesDraw(connection)
with col2:
    authorChapterDraw(connection)

st.divider()

# Average Rating and Count of each genre by Year of Publishing
def genreRatingCountYear(connection):
    genreFilter = st.multiselect(
    "SELECT GENRE",
    options=[
    "Action", "Adventure", "Comedy", "Drama", "Ecchi", "Fantasy", "Fan-fiction",
    "Gender bender", "Game", "Historical", "Isekai", "Lgbt+", "Magic", "Mature",
    "Martial arts", "Mecha", "Military", "Modern life", "Mystery", "Reincarnation",
    "Romance", "School life", "Sci-fi", "Seinen", "Shounen", "Shounen ai", "Smut",
    "Slice of life", "Supernatural", "Tragedy", "Urban life", "Video games", "Wuxia",
    "Xianxia", "Xuanhuan", "Yaoi"
    ]
,
    default=[
    "Action", "Adventure", "Comedy", "Drama", "Ecchi", "Fantasy", "Fan-fiction",
    "Gender bender", "Game", "Historical", "Isekai", "Lgbt+", "Magic", "Mature",
    "Martial arts", "Mecha", "Military", "Modern life", "Mystery", "Reincarnation",
    "Romance", "School life", "Sci-fi", "Seinen", "Shounen", "Shounen ai", "Smut",
    "Slice of life", "Supernatural", "Tragedy", "Urban life", "Video games", "Wuxia",
    "Xianxia", "Xuanhuan", "Yaoi"
    ]
    )
    df_full = pd.read_sql("SELECT genre, year, AVG(rating), count(rating) FROM Series natural join Series_Genre where year IS NOT NULL GROUP BY genre, year ORDER BY year asc;", connection)
    df_full_filtered = df_full.query("genre == @genreFilter")

    figavgRatingByYear = px.line(df_full_filtered, x="year", y="AVG(rating)", title="Average Rating of Each Genre by Year of Publishing", color="genre", markers=True, custom_data=['genre'])
    figavgRatingByYear.update_traces(
        hovertemplate='<b>Year:</b> %{x}<br><b>Average Rating:</b> %{y:.2f}<br><b>Genre:</b> %{customdata[0]}<extra></extra>'
    )
    figavgRatingByYear.update_layout(
        xaxis_title='Year of Publishing', 
        yaxis_title='Average Rating',
        hoverlabel=dict(
            font_size=16,  
            font_family='Arial, sans-serif', 
            font_color='black', 
        ),
        xaxis_title_font=dict(size=16, family="Arial, sans-serif", weight='bold'),
        yaxis_title_font=dict(size=16, family="Arial, sans-serif", weight='bold'),
        title={
            'x': 0.5,  
            'xanchor': 'center',
            'font': dict(size=16, family="Arial, sans serif")
        },
        xaxis=dict(
            tickfont=dict(
                size=16,
                # color='black',
                family='Arial, sans-serif',
                weight='bold'
            )
        ),
        yaxis=dict(
            tickfont=dict(
                size=16,
                # color='black',
                family='Arial, sans-serif',
                weight='bold'
            )
        ),
    )

    # Genre Count by Year of Publishing
    figCountByYear = px.line(df_full_filtered, x="year", y="count(rating)", title="Number of Each Genre by Year of Publishing", color="genre", markers=True, custom_data=['genre'])
    figCountByYear.update_traces(
        hovertemplate='<b>Year:</b> %{x}<br><b>Count:</b> %{y}<br><b>Genre:</b> %{customdata[0]}<extra></extra>',
    )
    figCountByYear.update_layout(
        xaxis_title='Year of Publishing', 
        yaxis_title='Count', 
        hoverlabel=dict(
            font_size=16,   
            font_family='Arial, sans-serif', 
            font_color='black',
        ),
        xaxis_title_font=dict(size=16, family="Arial, sans-serif", weight='bold'),
        yaxis_title_font=dict(size=16, family="Arial, sans-serif", weight='bold'),
        title={
            'x': 0.5,  
            'xanchor': 'center',
            'font': dict(size=16, family="Arial, sans serif")
        },
        xaxis=dict(
            tickfont=dict(
                size=16,
                # color='black',
                family='Arial, sans-serif',
                weight='bold'
            )
        ),
        yaxis=dict(
            tickfont=dict(
                size=16,
                # color='black',
                family='Arial, sans-serif',
                weight='bold'
            )
        ),
    )

    col1, col2 = st.columns(2)
    with col1:
        st.plotly_chart(figavgRatingByYear, use_container_width=True)
    with col2:
        st.plotly_chart(figCountByYear, use_container_width=True)
genreRatingCountYear(connection)

