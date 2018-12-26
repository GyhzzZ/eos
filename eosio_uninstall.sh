#! /bin/bash

binaries=(cleos
          eosio-abigen
          eosio-launcher
          eosio-s2wasm
          eosio-wast2wasm
          eosiocpp
          keosd
          nodeos
          eosio-applesdemo)

if [ -d "${HOME}/opt/eosio" ]; then
   printf "\tDo you wish to remove this install? (requires sudo)\n"
   select yn in "Yes" "No"; do
      case $yn in
         [Yy]* )
            pushd ~/opt &> /dev/null
            rm -rf eosio
            pushd ../bin &> /dev/null
            for binary in ${binaries[@]}; do
               rm ${binary}
            done
            brew remove mongo-cxx-driver
            brew remove mongo-c-driver
            rm -rf ~/opt/* # Delete everything from opt
            # Handle cleanup of directories created from installation
            if [ "$1" == "--full" ]; then
               if [ -d $HOME/Library/Application\ Support/eosio ]; then rm -rf $HOME/Library/Application\ Support/eosio; fi # Mac OS
               if [ -d $HOME/.local/share/eosio ]; then rm -rf $HOME/.local/share/eosio; fi # Linux
            fi
            popd &> /dev/null
            break;;
         [Nn]* )
            printf "\tAborting uninstall\n\n"
            exit -1;;
      esac
   done
fi
