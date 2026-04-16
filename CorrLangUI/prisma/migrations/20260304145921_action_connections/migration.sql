-- CreateTable
CREATE TABLE "ActionConnection" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT
);

-- CreateTable
CREATE TABLE "MethodConnection" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT
);

-- CreateTable
CREATE TABLE "_ActionToActionConnection" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    CONSTRAINT "_ActionToActionConnection_A_fkey" FOREIGN KEY ("A") REFERENCES "Action" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_ActionToActionConnection_B_fkey" FOREIGN KEY ("B") REFERENCES "ActionConnection" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_MethodToMethodConnection" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    CONSTRAINT "_MethodToMethodConnection_A_fkey" FOREIGN KEY ("A") REFERENCES "Method" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_MethodToMethodConnection_B_fkey" FOREIGN KEY ("B") REFERENCES "MethodConnection" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "_ActionToActionConnection_AB_unique" ON "_ActionToActionConnection"("A", "B");

-- CreateIndex
CREATE INDEX "_ActionToActionConnection_B_index" ON "_ActionToActionConnection"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_MethodToMethodConnection_AB_unique" ON "_MethodToMethodConnection"("A", "B");

-- CreateIndex
CREATE INDEX "_MethodToMethodConnection_B_index" ON "_MethodToMethodConnection"("B");
