module pknn

using Random

"""
Make two interleaving half circles.
(Taken from Python's scikit-learn)
"""
function make_moons(; n_samples::Int=100, shuffle_rows::Bool=true, noise::Float64=0.0,
                    random_state=nothing)

    n_samples_out = n_samples ÷ 2
    n_samples_in = n_samples - n_samples_out

    outer = range(0, stop=π, length=n_samples_out)
    inner = range(0, stop=π, length=n_samples_in)
    outer_circ_x = cos.(outer)
    outer_circ_y = sin.(outer)
    inner_circ_x = 1 .- cos.(inner)
    inner_circ_y = 1 .- sin.(inner) .- 0.5

    X = [outer_circ_x outer_circ_y; inner_circ_x inner_circ_y]
    y = [ones(n_samples_out); zeros(n_samples_in)]

    if noise >= 0
        X = X .+ randn(n_samples) * noise
    end

    if shuffle_rows
        new_indices = shuffle(1:n_samples)
        X = X[new_indices, :]
        y = y[new_indices]
    end

    return X, y
end

end # module
