#ifndef __HIETH_FEPHY_FIX_H
#define __HIETH_FEPHY_FIX_H

#define HIETH_SYSREG_BASE               ((void __iomem *)IO_ADDRESS(0xF8A22000))
#define HIETHPHY_SYSREG_REG             0x0120

#define INTERNAL_FEPHY_ADDR             ((void __iomem *)IO_ADDRESS(0xF8A20118))
#define HIETH_FEPHY_SELECT              ((void __iomem *)IO_ADDRESS(0xF8A20008))
#define HIETH_FEPHY_LDO_CTRL            ((void __iomem *)IO_ADDRESS(0xF8A20844))

/* DEFAULT external phy reset pin */
#define HIETH_FEPHY_RST_BASE            ((void __iomem *)IO_ADDRESS(0xF8A22168))
#define HIETH_FEPHY_RST_BIT             1

#define MII_EXPMD			0x1D
#define MII_EXPMA			0x1E

#define HISILICON_PHY_ID_FESTAV200	(0x20669823)
#define HISILICON_PHY_ID_FESTAV300	(0x20669833)
#define HISILICON_PHY_MASK		(0xfffffff0)

/* the following two copied from phy_quirk()
 * in "./drivers/net/ethernet/hieth-sf/net.c"
 */
#define PHY_ID_KSZ8051MNL		(0x00221550)
#define PHY_ID_KSZ8081RNB		(0x00221560)
#define DEFAULT_PHY_MASK		(0xfffffff0)

#endif
