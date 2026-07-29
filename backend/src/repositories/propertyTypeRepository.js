import prisma from "../config/prisma.js";

export async function getAllPropertyTypes() {
  return prisma.propertyType.findMany({
    where: {
      active: true,
    },
    orderBy: {
      name: "asc",
    },
  });
}