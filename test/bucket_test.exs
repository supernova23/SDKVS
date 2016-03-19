defmodule TS.BucketTest do
  use ExUnit.Case, async: true

  test "stores values by key" do
    {:ok, bucket} = TS.Bucket.start_link
    assert TS.Bucket.get(bucket, "milk") == nil

    TS.Bucket.put(bucket, "milk", 3)
    assert TS.Bucket.get(bucket, "milk") == 3
  end
end
