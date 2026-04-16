-- CreateTable
CREATE TABLE "AtrMultiConnection" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT
);

-- CreateTable
CREATE TABLE "_AtrMultiConnectionToAttribute" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    CONSTRAINT "_AtrMultiConnectionToAttribute_A_fkey" FOREIGN KEY ("A") REFERENCES "AtrMultiConnection" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_AtrMultiConnectionToAttribute_B_fkey" FOREIGN KEY ("B") REFERENCES "Attribute" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "_AtrMultiConnectionToAttribute_AB_unique" ON "_AtrMultiConnectionToAttribute"("A", "B");

-- CreateIndex
CREATE INDEX "_AtrMultiConnectionToAttribute_B_index" ON "_AtrMultiConnectionToAttribute"("B");
