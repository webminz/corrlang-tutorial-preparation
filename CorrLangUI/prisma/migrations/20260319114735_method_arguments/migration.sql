/*
  Warnings:

  - You are about to drop the column `inputs` on the `Method` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Method" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "actionID" INTEGER NOT NULL,
    "input" TEXT,
    "output" TEXT,
    CONSTRAINT "Method_actionID_fkey" FOREIGN KEY ("actionID") REFERENCES "Action" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Method" ("actionID", "id", "name", "output") SELECT "actionID", "id", "name", "output" FROM "Method";
DROP TABLE "Method";
ALTER TABLE "new_Method" RENAME TO "Method";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
