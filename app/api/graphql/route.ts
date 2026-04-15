import { createYoga } from "graphql-yoga";
import { prisma } from "@/lib/prisma";
import { builder } from "@/graphql/builder";
import "@/graphql/types";
import "@/graphql/schema";

const schema = builder.toSchema();

const { handleRequest } = createYoga({
  schema,
  context: () => ({
    prisma,
  }),
});

export async function GET(request: Request) {
  return handleRequest(request, {});
}

export async function POST(request: Request) {
  return handleRequest(request, {});
}
