import { Location } from "@/types/location";
import * as z from "zod";

export const filterQuerySchema = (validLocations: Location[]) =>
  z
    .object({
      station: z
        .string()
        .nullish()
        .refine((val) => {
          if (
            val &&
            !validLocations.map((loc) => loc.stationCode).includes(val)
          ) {
            return false;
          }
          return true;
        }),
      startDate: z.coerce.date().nullish(),
      endDate: z.coerce.date().nullish(),
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
