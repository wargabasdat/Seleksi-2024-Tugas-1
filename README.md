# CF Analytics.

## Description

Main reason why did I built this is because i always wanted to know how many problems are there, how many problems contains a specific tag, how many contests are there, and how many contests are there for a specific type. So for my curiousity, I scraped the codeforces website.

## Author

|   NIM    |           Nama           |
| :------: | :----------------------: |
| 13522066 | Nyoman Ganadipa Narayana |

## Tools / Library Used

- [MariaDB](https://mariadb.org/)
- [Next.js](https://nextjs.org/)
- [TailwindCSS](https://tailwindcss.com/)
- [shadcn/ui](https://ui.shadcn.com/)
- [recharts](https://recharts.org/en-US/)
- [gocolly](https://github.com/gocolly/colly)

## Data Scraping

### How To Run

1. Change dir into "/Data Scraping/src"

2. Scrapes the data from codeforces.com

```bash
go run main.go
```

3. While the data isn't complete (you can tell by config.json is not {}), do step 2, otherwise go step 4.

4. The complete data that we need is in ../data/data.json

### Scraped Data

The JSON format of the scraped data is

```js
{
    problems: ...
    contests: ...
}
```

- Inside the problems attribute there contains thousands of problems with each have its own id, title, url, tags, and rating.
- Inside the contests attribute there contains thousands of contests with each have its own id, name, writers, starttime, duration, and the number of participants.

## Data Modeling

### ERD
