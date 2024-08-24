from nixos/nix

RUN nix-channel --update

COPY ./shell.nix .
COPY ./home.nix /root/.config/home-manager/home.nix

RUN nix-env -e git bash-interactive wget coreutils-full man-db
RUN nix-shell --command "home-manager switch"

CMD [ "nix-shell" ]

