/*
  Warnings:

  - You are about to drop the column `method` on the `Action` table. All the data in the column will be lost.

*/
-- CreateTable
CREATE TABLE "Method" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "actionID" INTEGER NOT NULL,
    CONSTRAINT "Method_actionID_fkey" FOREIGN KEY ("actionID") REFERENCES "Action" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Action" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "schemaID" INTEGER NOT NULL,
    CONSTRAINT "Action_schemaID_fkey" FOREIGN KEY ("schemaID") REFERENCES "Schema" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Action" ("id", "name", "schemaID") SELECT "id", "name", "schemaID" FROM "Action";
DROP TABLE "Action";
ALTER TABLE "new_Action" RENAME TO "Action";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
