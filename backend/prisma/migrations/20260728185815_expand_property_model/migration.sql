/*
  Warnings:

  - You are about to drop the column `address` on the `Property` table. All the data in the column will be lost.
  - You are about to drop the column `area` on the `Property` table. All the data in the column will be lost.
  - You are about to drop the column `city` on the `Property` table. All the data in the column will be lost.
  - You are about to drop the column `operation` on the `Property` table. All the data in the column will be lost.
  - You are about to drop the column `province` on the `Property` table. All the data in the column will be lost.
  - You are about to drop the column `type` on the `Property` table. All the data in the column will be lost.
  - You are about to alter the column `price` on the `Property` table. The data in that column could be lost. The data in that column will be cast from `DoublePrecision` to `Decimal(15,2)`.
  - Added the required column `operationTypeId` to the `Property` table without a default value. This is not possible if the table is not empty.
  - Added the required column `propertyTypeId` to the `Property` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Property" DROP COLUMN "address",
DROP COLUMN "area",
DROP COLUMN "city",
DROP COLUMN "operation",
DROP COLUMN "province",
DROP COLUMN "type",
ADD COLUMN     "active" BOOLEAN NOT NULL DEFAULT true,
ADD COLUMN     "constructionArea" DECIMAL(10,2),
ADD COLUMN     "currency" TEXT NOT NULL DEFAULT 'DOP',
ADD COLUMN     "landArea" DECIMAL(10,2),
ADD COLUMN     "operationTypeId" INTEGER NOT NULL,
ADD COLUMN     "parkingSpaces" INTEGER,
ADD COLUMN     "propertyTypeId" INTEGER NOT NULL,
ALTER COLUMN "price" SET DATA TYPE DECIMAL(15,2);

-- CreateTable
CREATE TABLE "PropertyType" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PropertyType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OperationType" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "OperationType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Location" (
    "id" SERIAL NOT NULL,
    "propertyId" INTEGER NOT NULL,
    "province" TEXT NOT NULL,
    "municipality" TEXT,
    "sector" TEXT,
    "address" TEXT,
    "latitude" DECIMAL(10,7),
    "longitude" DECIMAL(10,7),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Location_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PropertyImage" (
    "id" SERIAL NOT NULL,
    "propertyId" INTEGER NOT NULL,
    "url" TEXT NOT NULL,
    "altText" TEXT,
    "sortOrder" INTEGER NOT NULL DEFAULT 0,
    "isCover" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "PropertyImage_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "PropertyType_name_key" ON "PropertyType"("name");

-- CreateIndex
CREATE UNIQUE INDEX "OperationType_name_key" ON "OperationType"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Location_propertyId_key" ON "Location"("propertyId");

-- AddForeignKey
ALTER TABLE "Property" ADD CONSTRAINT "Property_propertyTypeId_fkey" FOREIGN KEY ("propertyTypeId") REFERENCES "PropertyType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Property" ADD CONSTRAINT "Property_operationTypeId_fkey" FOREIGN KEY ("operationTypeId") REFERENCES "OperationType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Location" ADD CONSTRAINT "Location_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES "Property"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PropertyImage" ADD CONSTRAINT "PropertyImage_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES "Property"("id") ON DELETE CASCADE ON UPDATE CASCADE;
