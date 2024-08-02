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

Here is the ERD design for the database. Where Contributor table is stored is the contest writers, Problem table is stored the problems, Contest table is stored the contests, and Tag table is stored all kind of tags that a problem can have.
| ERD DESIGN |
| ----------------------------------------------------------------------------------------------------------------- |
| ![ERD Design](https://raw.githubusercontent.com/ganadipa/Seleksi-2024-Tugas-1/main/Data%20Storing/design/ERD.png) |

| Relational Database Table Design                                                                                                              |
| --------------------------------------------------------------------------------------------------------------------------------------------- |
| ![Relational Diagram Design](https://raw.githubusercontent.com/ganadipa/Seleksi-2024-Tugas-1/main/Data%20Storing/design/relational-model.png) |

How did i convert the ERD concept into the Relational database design?

- I converted all many to many relationships into a table that contains all the corresponding primary key. (ContributorContest and ProblemTag table)
- I handled all one to many relationship by providing the primary key of the "many" side into the "one", with that "one" side now also has "many" primary keys as its primary keys.

## Data Storing

Below is the proof that i had stored the scraped data into the dumped sql.

### Contest Table

| Contest Table                                                                                                                |
| ---------------------------------------------------------------------------------------------------------------------------- |
| ![Contest Table](https://raw.githubusercontent.com/ganadipa/Seleksi-2024-Tugas-1/main/Data%20Storing/screenshot/Contest.png) |

### Contributor Table

| Contributor Table                                                                                                                    |
| ------------------------------------------------------------------------------------------------------------------------------------ |
| ![Contributor Table](https://raw.githubusercontent.com/ganadipa/Seleksi-2024-Tugas-1/main/Data%20Storing/screenshot/Contributor.png) |

### ContributorContest Table

| ContributorContest Table                                                                                                                           |
| -------------------------------------------------------------------------------------------------------------------------------------------------- |
| ![ContributorContest Table](https://raw.githubusercontent.com/ganadipa/Seleksi-2024-Tugas-1/main/Data%20Storing/screenshot/ContributorContest.png) |

### Problem Table

| Problem Table                                                                                                                |
| ---------------------------------------------------------------------------------------------------------------------------- |
| ![Problem Table](https://raw.githubusercontent.com/ganadipa/Seleksi-2024-Tugas-1/main/Data%20Storing/screenshot/Problem.png) |

### ProblemTag Table

| ProblemTag Table                                                                                                                   |
| ---------------------------------------------------------------------------------------------------------------------------------- |
| ![ProblemTag Table](https://raw.githubusercontent.com/ganadipa/Seleksi-2024-Tugas-1/main/Data%20Storing/screenshot/ProblemTag.png) |

### Tag Table

| Tag Table                                                                                                            |
| -------------------------------------------------------------------------------------------------------------------- |
| ![Tag Table](https://raw.githubusercontent.com/ganadipa/Seleksi-2024-Tugas-1/main/Data%20Storing/screenshot/Tag.png) |

## Data Visualization

### How to run

1. cd "Data Visualization"/src
2. pnpm install && pnpm dev

## Special Thanks

Special thanks to Codeforces for providing the information. [codeforces.com](https://codeforces.com)
