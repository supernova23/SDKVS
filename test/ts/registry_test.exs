defmodule TS.RegistryTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, registry} = TS.Registry.start_link
    {:ok, registry: registry}
  end

  test "spawns buckets", %{registry: registry} do
    assert TS.Registry.lookup(registry, "shopping") == :error

    TS.Registry.create(registry, "shopping")
    assert {:ok, bucket} = TS.Registry.lookup(registry, "shopping")

    TS.Bucket.put(bucket, "milk", 1)
    assert TS.Bucket.get(bucket, "milk") == 1
  end

  test "remove buckets on exit", %{registry: registry} do
    TS.Registry.create(registry, "shopping")
     {:ok, bucket} = TS.Registry.lookup(registry, "shopping")
     Agent.stop(bucket)
     assert TS.Registry.lookup(registry, "shopping") == :error
  end
end
