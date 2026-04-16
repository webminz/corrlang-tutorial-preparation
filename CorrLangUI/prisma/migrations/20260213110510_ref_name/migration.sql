/*
  Warnings:

  - Added the required column `refName` to the `Edge` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Edge" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "srcNodeID" INTEGER NOT NULL,
    "trgtNodeID" INTEGER NOT NULL,
    "refName" TEXT NOT NULL,
    "lowerBound" INTEGER,
    "upperBound" INTEGER,
    "isOrdered" BOOLEAN NOT NULL DEFAULT false,
    "type" INTEGER NOT NULL DEFAULT 0,
    CONSTRAINT "Edge_srcNodeID_fkey" FOREIGN KEY ("srcNodeID") REFERENCES "Node" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Edge_trgtNodeID_fkey" FOREIGN KEY ("trgtNodeID") REFERENCES "Node" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Edge" ("id", "isOrdered", "lowerBound", "srcNodeID", "trgtNodeID", "type", "upperBound") SELECT "id", "isOrdered", "lowerBound", "srcNodeID", "trgtNodeID", "type", "upperBound" FROM "Edge";
DROP TABLE "Edge";
ALTER TABLE "new_Edge" RENAME TO "Edge";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
