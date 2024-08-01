export type TProblemRating = {
  rating: string;
  count: number;
};

export type TProblemTag = {
  tag: string;
  count: number;
};

// Define a union type from the array values
export type TContest =
  | "Div. 1"
  | "Div. 2"
  | "Div. 3"
  | "Div. 4"
  | "Global"
  | "ICPC"
  | "Other";

// Use Record utility type to create the TContestFrequency type
export type TContestFrequency = Record<TContest, number>;
