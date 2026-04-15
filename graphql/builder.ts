import SchemaBuilder from "@pothos/core";
import { PrismaClient } from "@prisma/client";

export const builder = new SchemaBuilder<{
  Context: {
    prisma: PrismaClient;
  };
}>({});

builder.queryType({});
builder.mutationType({});
