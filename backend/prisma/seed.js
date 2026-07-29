import { PrismaClient } from "../src/generated/prisma/index.js";

const prisma = new PrismaClient();

async function main() {

  // ==========================
  // Tipos de propiedad
  // ==========================

  await prisma.propertyType.createMany({
    data: [
      { name: "Apartamento" },
      { name: "Casa" },
      { name: "Villa" },
      { name: "Penthouse" },
      { name: "Terreno" },
      { name: "Local Comercial" },
      { name: "Oficina" },
      { name: "Nave Industrial" }
    ],
    skipDuplicates: true
  });

  // ==========================
  // Tipos de operación
  // ==========================

  await prisma.operationType.createMany({
    data: [
      { name: "Venta" },
      { name: "Alquiler" },
      { name: "Alquiler Temporal" }
    ],
    skipDuplicates: true
  });

  console.log("Catálogos creados correctamente.");

}

main()
  .catch(console.error)
  .finally(async () => {
    await prisma.$disconnect();
  });