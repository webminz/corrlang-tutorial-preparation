import messages from './client/core_pb.cjs';
import ccp from './client/ccp_pb.cjs';
import services from './client/core_grpc_pb.cjs';
import grpc from '@grpc/grpc-js';

// node ./src/lib/client/script.js

function main() {
  const client = new services.CoreServiceClient(
    'localhost:6969',
    grpc.credentials.createInsecure(),
  );

  // return new Promise((resolve, reject) => {
  //   const req = new messages.GetObjectsRequest();

  //   client.getObjects(req, async (error, object) => {
  //     if (error) {
  //       reject(error);
  //     } else {
  //       try {
  //         const corres = [];
  //         const objs = object.getObjectsList();
  //         for (const o of objs) {
  //           // Object === ENDPOINT=0
  //           // Object === CORRESPONDENCE=1
  //           if (o.getObjecttype() === 0) {
  //             // console.log(o.getId(), o.getName());
  //             corres.push({ id: o.getId(), title: o.getName() });
  //           }
  //         }
  //         console.log(corres);
  //         resolve(corres);
  //       } catch (dbError) {
  //         reject(dbError);
  //       }
  //     }
  //   });
  // });

  return new Promise((resolve, reject) => {
    const req = new messages.GetSchemaRequest();
    req.setEndpointid(1);

    client.getSchema(req, async (error, schema) => {
      if (error) {
        reject(error);
      } else {
        try {
          const elems = schema.getElementsList();

          for (const e of elems) {
            let t = e.getElementtype();
            if (t === ccp.SchemaElementKind.OBJECT_TYPE) {
              const n = e.getFullyqualifiedname().getPartsList()[0];
              console.log(` Element: ${n} `);
            }
            if (t === ccp.SchemaElementKind.ATTRIBUTE) {
              const atr = e.getFullyqualifiedname().getPartsList()[1];
              console.log(`   Attribute: ${atr} `);
            }
          }
          resolve('Node injection complete');
        } catch (dbError) {
          reject(dbError);
        }
      }
    });
  });
}

async function testServer() {
  await main();
}

testServer();
