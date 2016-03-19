defmodule TS.BucketTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, bucket} = TS.Bucket.start_link
    {:ok, bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
    assert TS.Bucket.get(bucket, "milk") == nil

    TS.Bucket.put(bucket, "milk", 3)
    assert TS.Bucket.get(bucket, "milk") == 3

    val = TS.Bucket.delete(bucket, "milk")
    assert val == 3
    assert TS.Bucket.get(bucket, "milk") == nil
  end
end
