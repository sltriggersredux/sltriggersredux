#pragma once

#include "RE/I/IFunctionArguments.h"
#include "RE/T/TypeTraits.h"
#include "RE/V/Variable.h"

#include <functional>
#include <vector>

namespace RE::BSScript
{
    class DynamicFunctionArguments : public IFunctionArguments
    {
    public:
        DynamicFunctionArguments() = default;

        // Push a single argument of any Pack-compatible type.
        // The type constraint mirrors the one on FunctionArguments<>.
        template <class T,
                  std::enable_if_t<is_return_convertible<std::decay_t<T>>::value, int> = 0>
        DynamicFunctionArguments& PushArg(T&& a_value)
        {
            // Capture a decayed copy so the caller's lifetime doesn't matter.
            _packers.emplace_back(
                [val = std::decay_t<T>(std::forward<T>(a_value))](Variable& a_var) mutable {
                    a_var.Pack(val);
                });
            return *this;  // fluent API — lets you chain calls
        }

        // IFunctionArguments interface
        bool operator()(BSScrapArray<Variable>& a_dst) const override
        {
            a_dst.resize(_packers.size());
            for (std::size_t i = 0; i < _packers.size(); ++i) {
                _packers[i](a_dst[i]);
            }
            return true;
        }

        [[nodiscard]] std::size_t size() const noexcept { return _packers.size(); }
        [[nodiscard]] bool        empty() const noexcept { return _packers.empty(); }

    private:
        std::vector<std::function<void(Variable&)>> _packers;
    };


    // Factory — returns a heap-allocated IFunctionArguments* (matching MakeFunctionArguments
    // conventions) that you can keep pushing into before passing to the VM.
    inline DynamicFunctionArguments* MakeDynamicFunctionArguments()
    {
        return new DynamicFunctionArguments();
    }
}