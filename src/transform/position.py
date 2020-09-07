from common import util

import numpy as np
import pandas as pd
import pyarrow as pa
import pyarrow.parquet as pq

# import common

# def xlambda_handler(event, context):
#    print("Hello from transform 1!")
#    # util.help1()
#    return {"statusCode": 200, "body": json.dumps("Hello from Lambda 5!")}


def do_transform():
    print("doing transformation for position")
    df = pd.DataFrame({'one': [-1, np.nan, 2.5],
        'two': ['foo', 'bar', 'baz'],
        'three': [True, False, True]},
        index=list('abc'))
    table = pa.Table.from_pandas(df, preserve_index=False)
    pq.write_table(table, '/tmp/example.parquet')
    
    table2 = pq.read_table('/tmp/example.parquet')
    print(table2.to_pandas())
    util.util_fn1()
