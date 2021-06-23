function NewAccount(initialBalance)
    local self = {
        balance = initialBalance,
        open = true
    }

    local withdraw = function (v)
        if self.open then
            if self.balance > v then
                self.balance = self.balance - v
            end
        else
            return "Bank account is closed"
        end
    end

    local deposit = function (v)
        if self.open then
            self.balance = self.balance + v
        else
            return "Bank account is closed"
        end
    end

    local getBalance = function ()
        if self.open then
            return "The remaining balance is " .. self.balance
        else
            return "Bank account is closed"
        end
    end

    local closeAccount = function ()
        self.open = not self.open
    end

    return {
        closeAccount = closeAccount,
        withdraw = withdraw,
        deposit = deposit,
        getBalance = getBalance
    }
end

function NewPaymentMethod(acc, method)
    local self = {
        account = acc,
        via = method
    }

    local pay = function (price)
        self.account.withdraw(price)
        return "Customer payed a total of: " .. price
    end

    local returnMoney = function (price)
        self.account.deposit(price)
    end

    return {
        pay = pay,
        returnMoney = returnMoney
    }
end

acc1 = NewAccount(100.00)
payment = NewPaymentMethod(acc1, "shop")

print(payment.pay(40.00))

print(acc1.getBalance())

acc1.closeAccount() -- close account

-- This should not work
payment.pay(40.00)
print(acc1.getBalance())
acc1.closeAccount() --open account
print(acc1.getBalance())
