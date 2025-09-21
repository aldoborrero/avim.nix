{
  pkgs,
  inputs,
  ...
}:
{
  avim = import ./avim {
    inherit pkgs inputs;
  };

  default = pkgs.avim;
}
