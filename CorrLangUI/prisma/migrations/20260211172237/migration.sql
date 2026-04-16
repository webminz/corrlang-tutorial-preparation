-- CreateTable
CREATE TABLE "Schema" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Node" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "positionX" INTEGER NOT NULL DEFAULT 50,
    "positionY" INTEGER NOT NULL DEFAULT 50,
    "schemaID" INTEGER NOT NULL,
    CONSTRAINT "Node_schemaID_fkey" FOREIGN KEY ("schemaID") REFERENCES "Schema" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Edge" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "srcNodeID" INTEGER NOT NULL,
    "trgtNodeID" INTEGER NOT NULL,
    "lowerBound" INTEGER,
    "upperBound" INTEGER,
    "isOrdered" BOOLEAN NOT NULL DEFAULT false,
    "type" INTEGER NOT NULL DEFAULT 0,
    CONSTRAINT "Edge_srcNodeID_fkey" FOREIGN KEY ("srcNodeID") REFERENCES "Node" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Edge_trgtNodeID_fkey" FOREIGN KEY ("trgtNodeID") REFERENCES "Node" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Attribute" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "nodeID" INTEGER NOT NULL,
    "text" TEXT NOT NULL,
    "type" TEXT,
    CONSTRAINT "Attribute_nodeID_fkey" FOREIGN KEY ("nodeID") REFERENCES "Node" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Connection" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "srcNodeID" INTEGER NOT NULL,
    "trgtNodeID" INTEGER NOT NULL,
    CONSTRAINT "Connection_srcNodeID_fkey" FOREIGN KEY ("srcNodeID") REFERENCES "Node" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Connection_trgtNodeID_fkey" FOREIGN KEY ("trgtNodeID") REFERENCES "Node" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "MultiConnection" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT
);

-- CreateTable
CREATE TABLE "AtrConnection" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "srcAtrID" INTEGER NOT NULL,
    "trgtAtrID" INTEGER NOT NULL,
    CONSTRAINT "AtrConnection_srcAtrID_fkey" FOREIGN KEY ("srcAtrID") REFERENCES "Attribute" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "AtrConnection_trgtAtrID_fkey" FOREIGN KEY ("trgtAtrID") REFERENCES "Attribute" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "_MultiConnectionToNode" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    CONSTRAINT "_MultiConnectionToNode_A_fkey" FOREIGN KEY ("A") REFERENCES "MultiConnection" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_MultiConnectionToNode_B_fkey" FOREIGN KEY ("B") REFERENCES "Node" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "_MultiConnectionToNode_AB_unique" ON "_MultiConnectionToNode"("A", "B");

-- CreateIndex
CREATE INDEX "_MultiConnectionToNode_B_index" ON "_MultiConnectionToNode"("B");
