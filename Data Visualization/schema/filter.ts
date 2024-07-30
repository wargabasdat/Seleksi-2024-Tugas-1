import * as z from "zod";

export const filterSchema = z
  .object({
    station: z.string().nullish(),
    startDate: z.date().nullish(),
    endDate: z.date().nullish(),
  })
  .superRefine((val, ctx) => {
    if ((val.startDate && !val.endDate) || (!val.startDate && val.endDate)) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message: "Both start date and end date must be provided",
      });
    }

    if (val.startDate && val.endDate && val.startDate > val.endDate) {
      ctx.addIssue({
        code: z.ZodIssueCode.custom,
        message: "Start date must be before end date",
        path: ["startDate", "endDate"],
      });
    }
  });
