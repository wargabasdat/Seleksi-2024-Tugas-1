import { type Metadata } from "next";

export const openGraphTemplate: Metadata["openGraph"] = {
  description:
    "Your interactive dashboard for comprehensive weather analytics. Explore historical data for any city, with customizable timeframes and detailed visualizations.",
  url: "http://localhost:3000",
  siteName: "WeatherWise",
  locale: "en-US",
  type: "website",
  images: {
    url: "http://localhost:3000/link-preview.jpg",
    width: "1200",
    height: "630",
    alt: "WeatherWise Logo",
  },
};

export const twitterTemplate: Metadata["twitter"] = {
  card: "summary_large_image",
  description:
    "Your interactive dashboard for comprehensive weather analytics. Explore historical data for any city, with customizable timeframes and detailed visualizations.",
  images: {
    url: "http://localhost:3000/link-preview.jpg",
    alt: "WeatherWise Logo",
  },
};
