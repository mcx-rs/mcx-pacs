# MCX Pacs

Peripherals access crate for NXP MCX series microcontroller.

Crates generated with `svdtools`, `svd2rust` and `form`.

## Generate

Install tools by running `make install_tools`, this will install
`svdtools`, `svd2rust` and `form` with specific version.

run `make crates`, the crates will show in `pacs` folder.

> Now this only support under Linux due to `svdtools` [issue](https://github.com/rust-embedded/svdtools/issues/189#issuecomment-1889821505)

## LICENSE

This project is licensed by [MIT](./LICENSE)

All original svd files comes from NXP's SDK with BSD-3-Clause License.
