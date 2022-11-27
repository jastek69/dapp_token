const { expect } = require('chai');
const { ethers } = require('hardhat');

const tokens = (n) => {
    return ethers.utils.parseUnits(n.toString(), 'ether') // converts 1000 to Ether = 1000000000000000000000000
}

describe('Token', ()=> {        // tests go inside here ... see https://hardhat.org/tutorial/testing-contracts
    let token

    beforeEach(async() => {
        // Fetch Token from Blockchain
        const Token = await ethers.getContractFactory('Token') // gets the actual Contract
        token = await Token.deploy('Sobek', 'SOB', '1000000')    // get Deployed instance of that contract
    })

    describe('Deployment', () => {
        const name = 'Sobek'
        const symbol = 'SOB'
        const decimals = '18'
        const totalSupply = tokens('1000000')

        it('has correct name', async () => {    // Read Token name. Check that name is correct ... see Chai matchers: https://ethereum-waffle.readthedocs.io/en/latest/matchers.html 
            expect(await token.name()).to.equal(name)
        })
    
        it('has correct symbol', async () => {  // Read Token symbol. Check that symbol is correct 
            expect(await token.symbol()).to.equal(symbol)
        })
    
        it('has correct decimals', async () => {  // Read Token decimals 
            expect(await token.decimals()).to.equal(decimals)
        })
    
        it('has correct total supply', async () => {  // Read Token total supply - converts 1000000 to Ether = 1000000000000000000000000
            expect(await token.totalSupply()).to.equal(totalSupply)
        })

    })

    // Describe Spending ...

    // Describe Approving ...

    // Describe ...
    
   

})
