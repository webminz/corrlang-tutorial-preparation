/*
  Warnings:

  - You are about to drop the `AtrMultiConnection` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Connection` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `MultiConnection` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_AtrMultiConnectionToAttribute` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_MultiConnectionToNode` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the column `srcAtrID` on the `AtrConnection` table. All the data in the column will be lost.
  - You are about to drop the column `trgtAtrID` on the `AtrConnection` table. All the data in the column will be lost.
  - You are about to drop the column `srcEdgeID` on the `EdgeConnection` table. All the data in the column will be lost.
  - You are about to drop the column `trgtEdgeID` on the `EdgeConnection` table. All the data in the column will be lost.

*/
-- DropIndex
DROP INDEX "_AtrMultiConnectionToAttribute_B_index";

-- DropIndex
DROP INDEX "_AtrMultiConnectionToAttribute_AB_unique";

-- DropIndex
DROP INDEX "_MultiConnectionToNode_B_index";

-- DropIndex
DROP INDEX "_MultiConnectionToNode_AB_unique";

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "AtrMultiConnection";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Connection";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "MultiConnection";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "_AtrMultiConnectionToAttribute";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "_MultiConnectionToNode";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "NodeConnection" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT
);

-- CreateTable
CREATE TABLE "_NodeToNodeConnection" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    CONSTRAINT "_NodeToNodeConnection_A_fkey" FOREIGN KEY ("A") REFERENCES "Node" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_NodeToNodeConnection_B_fkey" FOREIGN KEY ("B") REFERENCES "NodeConnection" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_EdgeToEdgeConnection" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    CONSTRAINT "_EdgeToEdgeConnection_A_fkey" FOREIGN KEY ("A") REFERENCES "Edge" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_EdgeToEdgeConnection_B_fkey" FOREIGN KEY ("B") REFERENCES "EdgeConnection" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_AtrConnectionToAttribute" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    CONSTRAINT "_AtrConnectionToAttribute_A_fkey" FOREIGN KEY ("A") REFERENCES "AtrConnection" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_AtrConnectionToAttribute_B_fkey" FOREIGN KEY ("B") REFERENCES "Attribute" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_AtrConnection" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT
);
INSERT INTO "new_AtrConnection" ("id") SELECT "id" FROM "AtrConnection";
DROP TABLE "AtrConnection";
ALTER TABLE "new_AtrConnection" RENAME TO "AtrConnection";
CREATE TABLE "new_EdgeConnection" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT
);
INSERT INTO "new_EdgeConnection" ("id") SELECT "id" FROM "EdgeConnection";
DROP TABLE "EdgeConnection";
ALTER TABLE "new_EdgeConnection" RENAME TO "EdgeConnection";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;

-- CreateIndex
CREATE UNIQUE INDEX "_NodeToNodeConnection_AB_unique" ON "_NodeToNodeConnection"("A", "B");

-- CreateIndex
CREATE INDEX "_NodeToNodeConnection_B_index" ON "_NodeToNodeConnection"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_EdgeToEdgeConnection_AB_unique" ON "_EdgeToEdgeConnection"("A", "B");

-- CreateIndex
CREATE INDEX "_EdgeToEdgeConnection_B_index" ON "_EdgeToEdgeConnection"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_AtrConnectionToAttribute_AB_unique" ON "_AtrConnectionToAttribute"("A", "B");

-- CreateIndex
CREATE INDEX "_AtrConnectionToAttribute_B_index" ON "_AtrConnectionToAttribute"("B");
